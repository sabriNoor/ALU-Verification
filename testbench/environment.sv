class Environment;
  Generator generator;
  Driver driver;
  Monitor monitor;
  Scoreboard scoreboard;
  mailbox #(Transaction) gen2drv;
  mailbox #(Transaction) mnt2sco;
  virtual alu4bit_if aluif;
  event drv_done;

  function new(virtual alu4bit_if aluif);
    gen2drv = new();
    mnt2sco = new();
    this.aluif = aluif;

    generator = new(gen2drv);
    driver = new(gen2drv, aluif, drv_done);
    monitor = new(mnt2sco, aluif, drv_done);
    scoreboard = new(mnt2sco);
  endfunction

  task run();
    fork
      generator.run();
      driver.run();
      monitor.run();
      scoreboard.run();
    join_none
  endtask
endclass
