module ula (
	input logic clk_ula,
	input logic rst,

	input logic [15:0] A,
	input logic [15:0] B,
	output logic [31:0] data_out,
	output logic valid_out,

	input logic [1:0] instru,

	input logic valid_ula
);

// 00 somar
// 01 subtrair
// 10 A + 1
// 11 B + 1

logic [1:0] counter;

logic [31:0] result;

logic [15:0] reg_A, reg_B;
logic [15:0] op_A, op_B;

logic start;
logic [1:0] reg_instru;
logic [1:0] op_instru;

assign op_instru = (valid_ula && counter == 0) ? instru : reg_instru;

assign op_A = (valid_ula && counter == 0) ? A : reg_A;
assign op_B = (valid_ula && counter == 0) ? B : reg_B;


always_comb
begin
	case (op_instru)
		2'b00:
		begin
			result = op_A + op_B;
		end
		2'b01:
		begin
			if(op_A > op_B)
				result = op_A - op_B;
			else
				result = op_B - op_A;
		end
		2'b10:
		begin
			result = op_A + 1;
		end
		2'b11:
		begin
			result = op_B + 1;
		end
	endcase
end



// Funcionamento reg A e reg B

always_ff @ (posedge clk_ula or negedge rst)
begin
	if(~rst)
	begin
		reg_A <= 0;
		reg_B <= 0;
	end
	else
	begin
		if(valid_ula && counter == 0)
		begin
			reg_A <= A;
			reg_B <= B;
		end
	end
end



always_comb
begin
	if(valid_ula || start)
	begin
		if(counter == op_instru)
		begin
			valid_out = 1;
			data_out = result;
		end
		else
		begin
			valid_out = 0;
			data_out = 0;
		end
	end
	else
	begin
		valid_out = 0;
		data_out = 0;
	end
end


// Counter para demorar algum tempo nas operações

always_ff @ (posedge clk_ula or negedge rst)
begin
	if(~rst)
	begin
		counter <= 2'b00;
		start <= 0;
	end
	else
	begin
		
		start <= (valid_ula) ? ((counter == op_instru) ? 0 : 1) : ((counter == op_instru) ? 0 : start);

		reg_instru <= (valid_ula) ? ((counter == 0) ? instru : reg_instru) : reg_instru;

		if(start || valid_ula)
		begin
			if(counter == op_instru)
			begin
				counter <= 0;
			end
			else
			begin
				counter <= counter + 1;
			end
		end
	end
end


endmodule