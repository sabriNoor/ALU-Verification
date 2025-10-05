class Generator;
  mailbox #(Transaction) gen2drv;
  Transaction transaction;

  function new(mailbox #(Transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task run();
    forever begin
      transaction = new();
      if(!transaction.randomize()) $finish;
      gen2drv.put(transaction);
      transaction.print("Generator");
      #10; 
    end
  endtask
endclass