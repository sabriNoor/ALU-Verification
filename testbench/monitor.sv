class Monitor;
  mailbox #(Transaction) mnt2sco;
  mailbox #(Transaction) mnt2cov;
  virtual alu4bit_if aluif;
  event drv_done;
  Transaction cov_tr;
  Transaction transaction;
  
  function new(mailbox #(Transaction) mnt2sco, 
               mailbox #(Transaction) mnt2cov, 
               virtual alu4bit_if aluif,
               event drv_done);
    this.mnt2sco = mnt2sco;
    this.mnt2cov = mnt2cov;
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

      cov_tr = new();
      cov_tr.copy(transaction);  
      mnt2cov.put(cov_tr);
    end
  endtask
endclass