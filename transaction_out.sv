class transaction_out extends uvm_sequence_item;
  rand bit [31:0] data_o;

  function new(string name = "");
    super.new(name);
  endfunction

  `uvm_object_param_utils_begin(transaction_out)
    `uvm_field_int(data_o, UVM_ALL_ON)
  `uvm_object_utils_end

  function string convert2string();
    return $sformatf("{data_o = %d}",data_o);
  endfunction
endclass