class Environment;
  Generator generator;
  Driver driver;
  Monitor monitor;
  Scoreboard scoreboard;
  Coverage coverage;
  mailbox #(Transaction) gen2drv;
  mailbox #(Transaction) mnt2sco;
  mailbox #(Transaction) mnt2cov;
  virtual alu4bit_if aluif;
  event drv_done;

  function new(virtual alu4bit_if aluif);
    gen2drv = new();
    mnt2sco = new();
    mnt2cov = new();
    this.aluif = aluif;

    generator = new(gen2drv);
    driver = new(gen2drv, aluif, drv_done);
    monitor = new(mnt2sco, mnt2cov, aluif, drv_done);
    scoreboard = new(mnt2sco);
    coverage = new(mnt2cov);
  endfunction

  task run();
    fork
      generator.run();
      driver.run();
      monitor.run();
      scoreboard.run();
      coverage.run(); 
    join_none
  endtask
  
  function void report_coverage();
    coverage.report();
  endfunction
endclass