typedef virtual interface_if.mst interface_vif;

class driver extends uvm_driver #(transaction_in);
    `uvm_component_utils(driver)
    interface_vif vif;
    event begin_record, end_record;
    transaction_in tr;
    bit item_done, first_tr;

    function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(interface_vif)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "failed to get virtual interface")
        end
    endfunction

    task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        wait(vif.rst===0);
        item_done = 1'b0;
        tr = null;
        vif.data_i  <= '0;
        vif.reg_sel <= '0;
        vif.instru  <= '0;
        vif.valid_i <= '0;
        first_tr = 1;
        @(posedge vif.clk iff vif.rst);
        phase.drop_objection(this);
    endtask : reset_phase

    task main_phase (uvm_phase phase);

        forever begin
            @(posedge vif.clk) begin

                item_done = 1'b0;
                vif.valid_i = 1'b0;
                if(tr && (vif.valid_o || first_tr)) begin
                    $display("data_i = ",tr.data_i);
                    $display("reg_sel = ",tr.reg_sel);
                    $display("instru = ",tr.instru);
                    vif.data_i  <= tr.data_i;
                    vif.reg_sel <= tr.reg_sel;
                    vif.instru  <= tr.instru;
                    vif.valid_i <= 1'b1;
                    item_done = 1;
                    first_tr = 0;
                end
  
                if (item_done) begin
                    `uvm_info("ITEM_DONE", $sformatf("Item done. = %b",item_done), UVM_LOW);
                    seq_item_port.item_done();
                end

                if (item_done || !tr) begin
                  seq_item_port.try_next_item(tr);
                end
            end
        end
    endtask
endclass