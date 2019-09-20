module rb (
	input logic clk_reg,
	input logic rst,

	input logic [1:0] addr,
	input logic [15:0] data_in,
	input logic valid_reg,

	output logic [15:0] reg1,
	output logic [15:0] reg2,
	output logic [15:0] reg3,
	output logic [15:0] reg4
	
);

logic [15:0] registers [4];

always_comb
begin
	reg1 = registers[0];
	reg2 = registers[1];
	reg3 = registers[2];
	reg4 = registers[3];
end

always_ff @ (posedge clk_reg or negedge rst)
begin
	if(~rst)
	begin
		foreach(registers[i])
		begin
			registers[i] <= 0;
		end
	end
	else
	begin
		if(valid_reg)
		begin
			registers[addr] <= data_in;
		end
	end
end

endmodule