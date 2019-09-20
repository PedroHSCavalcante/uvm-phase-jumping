module datapath (
	input logic clk_ula,
	input logic clk_reg,
	input logic rst,

	input logic valid_reg,
	input logic [1:0] addr,
	input logic [15:0] data_in,

	input logic [1:0] reg_sel,

	input logic valid_ula,
	input logic [1:0] instru,
	input logic [15:0] A,
	output logic [31:0] data_out,
	output logic valid_out
);

logic [15:0] data_out_mux;
logic [15:0] reg1;
logic [15:0] reg2;
logic [15:0] reg3;
logic [15:0] reg4;

ula ULA(
	.clk_ula(clk_ula),
	.rst(rst),

	.A(A),
	.B(data_out_mux),
	.data_out(data_out),
	.valid_out(valid_out),

	.instru(instru),

	.valid_ula(valid_ula)
);

rb REG(
	.clk_reg(clk_reg),
	.rst(rst),

	.addr(addr),
	.data_in(data_in),
	.valid_reg(valid_reg),

	.reg1(reg1),
	.reg2(reg2),
	.reg3(reg3),
	.reg4(reg4)
	
);

mux MUX(
	.reg_sel(reg_sel),

	.reg1(reg1),
	.reg2(reg2),
	.reg3(reg3),
	.reg4(reg4),

	.data_out_mux(data_out_mux)
);

endmodule