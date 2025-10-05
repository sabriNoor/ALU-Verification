module ALU4bit (
  input  logic [3:0] a, b,
  input alu_definitions::alu_op_t op,
  input  logic clk, reset,
  output logic [4:0] c
);
  
  import alu_definitions::*;

  always @(posedge clk or negedge reset) begin
    if (!reset) 
      c <= 0;         
     else begin
       case (op)
         OP_ADD: c <= a + b;
         OP_SUB: c <= a - b;
         OP_AND: c <= a & b;
         OP_OR:  c <= a | b;
         OP_XOR: c <= a ^ b;
         OP_NOR: c <= ~(a | b);
         OP_SLT: c <= a < b ? 1 : 0;
         OP_SLL: c <= a << b[1:0];
         default: c <= a + b;
        endcase                
     end    
  end
endmodule