class Transaction;
  import alu_definitions::*; 
  
  rand logic [3:0] a;
  rand logic [3:0] b;
  rand alu_op_t op; 
  rand logic reset;
  logic [4:0] c;

  constraint ctrans { 
    reset dist {1 := 90, 0 := 10}; 
    op dist {
      OP_ADD := 20,
      OP_SUB := 15,
      OP_AND := 15,
      OP_OR  := 15,
      OP_XOR := 15,
      OP_NOR := 5,
      OP_SLT := 5,
      OP_SLL := 10
    };
  }

  function void print(string tag="");
    $display("T=%0t [%s] a=%0d b=%0d op=%s reset=%0b c=%0d", 
             $time, tag, a, b, alu_definitions::get_op_name(op), reset, c);
  endfunction
endclass