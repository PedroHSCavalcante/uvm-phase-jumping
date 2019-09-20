class scoreboard extends uvm_scoreboard;

  typedef transaction_out T;
  typedef uvm_in_order_class_comparator #(T) comp_type;

  refmod rfm;
  comp_type comp;

  uvm_analysis_port #(T) ap_comp;
  uvm_analysis_port #(transaction_in) ap_rfm;
  uvm_analysis_port #(transaction_rb) ap_rb;

  `uvm_component_utils(scoreboard)

  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    ap_comp = new("ap_comp", this);
    ap_rfm = new("ap_rfm", this);
    ap_rb = new("ap_rb", this);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rfm = refmod::type_id::create("rfm", this);
    comp = comp_type::type_id::create("comp", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ap_comp.connect(comp.before_export);
    ap_rfm.connect(rfm.in);
    ap_rb.connect(rfm.rb_in);
    rfm.out.connect(comp.after_export);
  endfunction
endclass : scoreboard