module top;
  bit clk = 0;
  Test test;
  always #10 clk = ~clk;

  alu4bit_if aluif(clk);
  ALU4bit dut(.a(aluif.a), .b(aluif.b), .op(aluif.op), .clk(aluif.clk), 
              .reset(aluif.reset), .c(aluif.c));

  initial begin
    test = new(aluif);
    $display("=== Enhanced 4-bit ALU Testbench with Coverage ===");
    $display("Operations: ADD, SUB, AND, OR, XOR, NOR, SLT, SLL");
    test.run();
    #10000; 
    
    test.env.report_coverage();
    
    $display("=== Simulation Complete ===");
    $finish;
  end
  
  initial begin
    #15000;
    $display("Simulation timeout reached");
    $finish;
  end
endmodule