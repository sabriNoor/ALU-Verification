class Scoreboard;
  
  import alu_definitions::*; 
  mailbox #(Transaction) mnt2sco;

  function new(mailbox #(Transaction) mnt2sco);
    this.mnt2sco = mnt2sco;
  endfunction

  function automatic void check_result(bit [3:0] a, bit [3:0] b, alu_op_t op, bit reset, bit [4:0] c);
    bit [4:0] expected_result;
    if (reset == 0)
      expected_result = 0;
    else begin
      case (op)
         OP_ADD: expected_result=a+b;
         OP_SUB: expected_result=a-b;
         OP_AND: expected_result=a&b;
         OP_OR: expected_result=a|b;
         OP_XOR: expected_result=a^b;
         OP_NOR: expected_result=~(a|b);
         OP_SLT: expected_result=a<b?1:0;
         OP_SLL: expected_result=a<<b[1:0];
    
        endcase      
    end

    if (expected_result != c)
      $display("FAIL: a=%0b b=%0b op=%s reset=%0b expected c=%0b got c=%0b",
               a, b, get_op_name(op), reset, expected_result, c);
    else
      $display("PASS: a=%0b b=%0b op=%s reset=%0b c=%0",
               a, b, get_op_name(op), reset, c);
  endfunction

  task run();
    forever begin
      Transaction transaction;
      mnt2sco.get(transaction);
      transaction.print("Scoreboard");
      check_result(transaction.a, transaction.b,transaction.op ,transaction.reset, transaction.c);
    end
  endtask
endclass