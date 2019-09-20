class monitor_rb extends uvm_monitor;

    rb_vif  vif;
    event begin_record, end_record;
    transaction_rb tr_rb;
    uvm_analysis_port #(transaction_rb) req_port;
    `uvm_component_utils(monitor_rb)
   
    function new(string name, uvm_component parent);
        super.new(name, parent);
        req_port = new ("req_port", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
         if(!uvm_config_db#(rb_vif)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "failed to get virtual interface")
        end
        tr_rb = transaction_rb::type_id::create("tr_rb", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        fork
            collect_transactions(phase);
        join
    endtask

    virtual task collect_transactions(uvm_phase phase);
        forever begin

            @(posedge vif.clk) begin
                if(vif.valid_i) begin
                    @(negedge vif.valid_i);
                    begin_tr(tr_rb, "req");
                    tr_rb.data_i = vif.data_i;
                    tr_rb.addr = vif.addr;
                    req_port.write(tr_rb);
                    end_tr(tr_rb);
                end
            end
        end
    endtask
endclass
