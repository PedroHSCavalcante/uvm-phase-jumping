class coverage extends uvm_component;

  `uvm_component_utils(coverage)

  transaction_in req;
  uvm_analysis_imp#(transaction_in, coverage) req_port;

  int min_tr;
  int n_tr = 0;

  event end_of_simulation;

  function new(string name = "coverage", uvm_component parent= null);
    super.new(name, parent);
    req_port = new("req_port", this);
    req=new;
    min_tr = 10000;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase (phase);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    @(end_of_simulation);
    phase.drop_objection(this);
  endtask: run_phase

  
  function void write(transaction_in t);
    n_tr = n_tr + 1;
    if(n_tr >= min_tr)begin
      ->end_of_simulation;
    end
  endfunction: write

endclass : coverage