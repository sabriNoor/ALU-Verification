class Transaction;
  rand logic [3:0] a;
  rand logic [3:0] b;
  rand alu_definitions::alu_op_t op; 
  rand logic reset;
  logic [4:0] c;

  constraint ctrans { 
    reset dist {1 := 90, 0 := 10}; 
    op dist {
      alu_definitions::OP_ADD := 20,
      alu_definitions::OP_SUB := 15,
      alu_definitions::OP_AND := 15,
      alu_definitions::OP_OR  := 15,
      alu_definitions::OP_XOR := 15,
      alu_definitions::OP_NOR := 5,
      alu_definitions::OP_SLT := 5,
      alu_definitions::OP_SLL := 10
    };
  }

  function void print(string tag="");
    $display("T=%0t [%s] a=%0d b=%0d op=%s reset=%0b c=%0d", 
             $time, tag, a, b, alu_definitions::get_op_name(op), reset, c);
  endfunction
  
  function void copy(Transaction tr);
    this.a = tr.a;
    this.b = tr.b;
    this.c = tr.c;
    this.op = tr.op;
    this.reset = tr.reset;
  endfunction
endclass