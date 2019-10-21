class sequence_in extends uvm_sequence #(transaction_in);
    `uvm_object_utils(sequence_in)

    function new(string name="sequence_in");
        super.new(name);
    endfunction: new

    task body;
        transaction_in tr;

        tr = transaction_in::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize());
        finish_item(tr);

    endtask: body
endclass: sequence_in