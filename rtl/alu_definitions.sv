package alu_definitions;
  typedef enum logic [2:0] {
    OP_ADD  = 3'b000,  // Addition: a + b
    OP_SUB  = 3'b001,  // Subtraction: a - b
    OP_AND  = 3'b010,  // Bitwise AND: a & b
    OP_OR   = 3'b011,  // Bitwise OR: a | b
    OP_XOR  = 3'b100,  // Bitwise XOR: a ^ b
    OP_NOR  = 3'b101,  // Bitwise NOR: ~(a | b)
    OP_SLT  = 3'b110,  // Set less than: a < b ? 1 : 0
    OP_SLL  = 3'b111   // Shift left logical: a << b[1:0]
  } alu_op_t;
  
  function automatic string get_op_name(alu_op_t op);
    case (op)
      OP_ADD: return "ADD";
      OP_SUB: return "SUB"; 
      OP_AND: return "AND";
      OP_OR:  return "OR";
      OP_XOR: return "XOR";
      OP_NOR: return "NOR";
      OP_SLT: return "SLT";
      OP_SLL: return "SLL";
      default: return "UNKNOWN";
    endcase
  endfunction
endpackage