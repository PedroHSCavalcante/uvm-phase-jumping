import "DPI-C" context function int my_ula(int x,int y,int z);

`uvm_analysis_imp_decl(_ula)
`uvm_analysis_imp_decl(_rb)

class refmod extends uvm_component;
    `uvm_component_utils(refmod)

    bit [15:0] registers[4];
    
    transaction_in tr_in;
    transaction_out tr_out;
    transaction_rb tr_rb;
    
    uvm_analysis_imp_ula#(transaction_in, refmod) in;
    uvm_analysis_imp_rb#(transaction_rb, refmod) rb_in;
    uvm_analysis_port #(transaction_out) out;
    
    event begin_refmodtask ,begin_task_rb;

    function new(string name = "refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        rb_in = new("rb_in", this);
        out = new("out", this);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr_out = transaction_out::type_id::create("tr_out", this);
    endfunction: build_phase

    task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        registers[0] = 16'hC4F3;
        registers[1] = 16'hB45E;
        registers[2] = 16'hD1E5;
        registers[3] = 16'h1DE4;
        $display("REG3  =  %h",registers[3] );
        phase.drop_objection(this);
    endtask : reset_phase

    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);
        fork
            forever begin
                @begin_refmodtask;
                $display("REG3  =  %h",registers[3] );
                $display("REG2  =  %h",registers[2] );
                tr_out = transaction_out::type_id::create("tr_out", this);
                tr_out.data_o = my_ula(tr_in.data_i,registers[tr_in.reg_sel],tr_in.instru);
                out.write(tr_out);
            end
            forever begin
                @begin_task_rb;
                registers[tr_rb.addr] = tr_rb.data_i;
            end
        join
    endtask: main_phase

    virtual function write_ula (transaction_in t);
        tr_in = transaction_in#()::type_id::create("tr_in", this);
        tr_in.copy(t);
       -> begin_refmodtask;
    endfunction

    virtual function write_rb (transaction_rb t);
        tr_rb = transaction_rb#()::type_id::create("tr_rb", this);
        tr_rb.copy(t);
       -> begin_task_rb;
    endfunction

endclass: refmod