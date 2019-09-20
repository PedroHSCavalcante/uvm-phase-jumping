interface interface_rb(input clk, rst);
    logic [15:0] data_i;
    logic  [1:0] addr;
    logic        valid_i;
    
    modport mst(input clk, rst, output data_i, addr, valid_i);
endinterface
