class simple_test extends uvm_test;
  env env_h;
  sequence_in seq;
  sequence_rb seq_rb;
  bit flag;

  `uvm_component_utils(simple_test)

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
    flag = 0;
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_h = env::type_id::create("env_h", this);
    seq = sequence_in::type_id::create("seq", this);
    seq_rb = sequence_rb::type_id::create("seq_rb", this);
  endfunction

  task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    fork
      seq.start(env_h.mst.sqr);
      seq_rb.start(env_h.mst_rb.sqr);
      begin
        if(!flag) begin
          @(negedge env_h.mst_rb.drv.vif.rst);
          flag = 1;
        end
        @(negedge env_h.mst_rb.drv.vif.rst);
        phase.drop_objection(this);
        phase.jump(uvm_pre_reset_phase::get());
      end
    join
  endtask: main_phase

endclass
