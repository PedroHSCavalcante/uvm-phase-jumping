interface interface_if(input clk, rst);
    logic [15:0] data_i;
    logic  [1:0] reg_sel;
    logic  [1:0] instru;
    logic        valid_i;
    logic [31:0] data_o;
    logic 		 valid_o;
    
    modport mst(input clk, rst, data_o, valid_o, output data_i, reg_sel, valid_i, instru);
    modport slv(input clk, rst, data_i, valid_i, reg_sel, output data_o, valid_o);
endinterface
