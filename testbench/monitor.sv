class Monitor;
  mailbox #(Transaction) mnt2sco;
  virtual alu4bit_if aluif;
  Transaction transaction;
  event drv_done;
  
  function new(mailbox #(Transaction) mnt2sco, virtual alu4bit_if aluif,event drv_done);
    this.mnt2sco = mnt2sco;
    this.aluif = aluif;
    this.drv_done = drv_done;
  endfunction

  task run(); 
   
    forever begin
      @(drv_done);
      transaction = new();
      
      transaction.a = aluif.a;
      transaction.b = aluif.b;
      transaction.op = aluif.op;
      transaction.reset = aluif.reset;
      
      @(posedge aluif.clk);
      
      transaction.c = aluif.c;
      transaction.print("Monitor");
      mnt2sco.put(transaction);
      
    end
  endtask
endclass