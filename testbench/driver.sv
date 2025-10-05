class Driver;
  mailbox #(Transaction) gen2drv;
  virtual alu4bit_if aluif;
  event drv_done;

  function new(mailbox #(Transaction) gen2drv, virtual alu4bit_if aluif, event drv_done);
    this.gen2drv = gen2drv;
    this.aluif = aluif;
    this.drv_done = drv_done;
  endfunction

  task run();
    forever begin
      Transaction transaction;
      gen2drv.get(transaction);
      transaction.print("Driver");
      @(posedge aluif.clk);
      aluif.a <= transaction.a;
      aluif.b <= transaction.b;
      aluif.op <= transaction.op;
      aluif.reset <= transaction.reset;
      @(posedge aluif.clk);
      ->drv_done;
    end
  endtask
endclass