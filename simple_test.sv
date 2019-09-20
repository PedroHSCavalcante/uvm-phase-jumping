class simple_test extends uvm_test;
  env env_h;
  sequence_in seq;
  sequence_rb seq_rb;

  `uvm_component_utils(simple_test)

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_h = env::type_id::create("env_h", this);
    seq = sequence_in::type_id::create("seq", this);
    seq_rb = sequence_rb::type_id::create("seq_rb", this);
  endfunction

  task run_phase(uvm_phase phase);
    fork
      seq.start(env_h.mst.sqr);
      seq_rb.start(env_h.mst_rb.sqr);
    join
  endtask: run_phase

endclass
