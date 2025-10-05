class Coverage;
  mailbox #(Transaction) cov_mailbox;
  
  logic [2:0] op_cp;
  logic reset_cp;
  logic [3:0] a_cp, b_cp;
  
  covergroup alu_cg;
    option.per_instance = 1;
    
    coverpoint op_cp {
      bins op_add = {3'b000};
      bins op_sub = {3'b001};
      bins op_and = {3'b010};
      bins op_or  = {3'b011};
      bins op_xor = {3'b100};
      bins op_nor = {3'b101};
      bins op_slt = {3'b110};
      bins op_sll = {3'b111};
    }
    
    coverpoint reset_cp {
      bins reset_active = {0};
      bins reset_inactive = {1};
    }
    
    coverpoint a_cp {
      bins a_zero = {0};
      bins a_low  = {[1:7]};
      bins a_high = {[8:15]};
    }
    
    coverpoint b_cp {
      bins b_zero = {0};
      bins b_low  = {[1:7]};
      bins b_high = {[8:15]};
    }
  endgroup
  
  Transaction cov_queue[$];
  int sample_count = 0;
  
  function new(mailbox #(Transaction) cov_mailbox);
    this.cov_mailbox = cov_mailbox;
    alu_cg = new();
  endfunction
  
  task run();
    forever begin
      Transaction tr;
      cov_mailbox.get(tr);
      cov_queue.push_back(tr);
      sample_count++;
      
      if (tr.reset == 1) begin
        op_cp = tr.op;
        reset_cp = tr.reset;
        a_cp = tr.a;
        b_cp = tr.b;
        alu_cg.sample();
      end
      else begin
        reset_cp = tr.reset;
        alu_cg.sample();
      end
      
      if (sample_count > 500) break;
    end
  endtask
  
  function void report();
    $display("\n=== COVERAGE REPORT ===");
    $display("Samples collected: %0d", sample_count);
    $display("Overall Coverage: %0.2f%%", alu_cg.get_inst_coverage());
    $display("Operation Coverage: %0.2f%%", alu_cg.op_cp.get_coverage());
    $display("Reset Coverage: %0.2f%%", alu_cg.reset_cp.get_coverage());
    $display("Input A Coverage: %0.2f%%", alu_cg.a_cp.get_coverage());
    $display("Input B Coverage: %0.2f%%", alu_cg.b_cp.get_coverage());
  endfunction
endclass