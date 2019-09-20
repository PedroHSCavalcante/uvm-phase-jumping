class sequence_rb extends uvm_sequence #(transaction_rb);
    `uvm_object_utils(sequence_rb)

    function new(string name="sequence_rb");
        super.new(name);
    endfunction: new

    task body;
        transaction_rb tr;

        forever begin
            tr = transaction_rb::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize());
            finish_item(tr);
        end
    endtask: body
endclass: sequence_rb