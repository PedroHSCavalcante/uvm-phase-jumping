module mux (
	input logic [1:0] reg_sel,

	input logic [15:0] reg1,
	input logic [15:0] reg2,
	input logic [15:0] reg3,
	input logic [15:0] reg4,

	output logic [15:0] data_out_mux
);

always_comb
begin
	case (reg_sel)
		2'b00: data_out_mux = reg1;
		2'b01: data_out_mux = reg2;
		2'b10: data_out_mux = reg3;
		2'b11: data_out_mux = reg4;
	endcase
end

endmodule