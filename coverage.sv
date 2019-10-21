class coverage extends uvm_component;

  `uvm_component_utils(coverage)

  transaction_in req;
  uvm_analysis_imp#(transaction_in, coverage) req_port;

  int n_tr = 0;

  event end_of_simulation;

  // covergroup cg();
  //   //add your covergroup
  // endgroup : cg

  function new(string name = "coverage", uvm_component parent= null);
    super.new(name, parent);
    req_port = new("req_port", this);
    req = new;
    // cg = new;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase (phase);
  endfunction

  task main_phase(uvm_phase phase);
    // phase.raise_objection(this);
  endtask: main_phase
  
  function void write(transaction_in t);
    req.copy(t);
    // cg.sample();
    // if($get_coverage() == 100)
    //   running_phase.drop_objection(this);
  endfunction: write

endclass : coverage