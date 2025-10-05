module top;
  
  bit clk = 0;
  always #10 clk = ~clk;

  alu4bit_if aluif(clk);
  Test test = new(aluif);
  ALU4bit dut(.a(aluif.a), .b(aluif.b), .op(aluif.op) , .clk(aluif.clk), 
              .reset(aluif.reset), .c(aluif.c));

  initial begin
    test.run();
    #10000 $finish;
  end
endmodule