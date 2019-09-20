class transaction_rb extends uvm_sequence_item;
  rand bit [31:0] data_i;
  rand bit [31:0] addr;

  function new(string name = "");
    super.new(name);
  endfunction

  `uvm_object_param_utils_begin(transaction_rb)
    `uvm_field_int(data_i, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
  `uvm_object_utils_end

  function string convert2string();
    return $sformatf("{data_i = %d, addr = %d}",data_i, addr);
  endfunction
endclass