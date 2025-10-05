interface alu4bit_if (input bit clk);

  logic [3:0] a, b;
  logic reset;
  logic [4:0] c;
  alu_definitions::alu_op_t op;

  modport Test (input clk, c, output a, b, reset, op);
  modport Design (input clk, reset, a, b, op, output c);
endinterface