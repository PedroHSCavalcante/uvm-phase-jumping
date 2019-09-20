typedef virtual interface_rb.mst rb_vif;

class driver_rb extends uvm_driver #(transaction_rb);
    `uvm_component_utils(driver_rb)
    rb_vif vif;
    event begin_record, end_record;
    transaction_rb tr;
    bit item_done;

    function new(string name = "driver_rb", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
         if(!uvm_config_db#(rb_vif)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "failed to get virtual interface")
        end
    endfunction

    task run_phase (uvm_phase phase);

        forever begin
            @(posedge vif.clk) begin

                item_done = 1'b0;
                vif.valid_i = 1'b0;

                if(vif.rst) begin
                    repeat(10) @(posedge vif.clk);
                end

                if(!vif.rst) begin
                    vif.data_i  <= '0;
                    vif.addr    <= '0;
                    vif.valid_i <= '0;
                    item_done = 0;
                end
                else begin
                    if(tr)begin
                        $display("data_i = ",tr.data_i);
                        $display("addr = ",tr.addr);
                        vif.data_i  <= tr.data_i;
                        vif.addr <= tr.addr;
                        vif.valid_i <= 1'b1;
                        item_done = 1;
                    end
                end

                if (item_done) begin
                    `uvm_info("ITEM_DONE", $sformatf("Item done."), UVM_HIGH);
                    seq_item_port.item_done();
                end
                if ((item_done || !tr) && vif.rst) begin
                    seq_item_port.try_next_item(tr);
                end
            end
        end
    endtask

endclass