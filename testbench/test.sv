class Test;
  Environment env;

  function new(virtual alu4bit_if aluif);
    env = new(aluif);
  endfunction

  task run();
    env.run();
  endtask
endclass