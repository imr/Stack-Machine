`timescale 1ns / 1ps

module stack(top_out,next_out,top_in,next_in,pop,push,w_tos,w_next,clk,rst);
	output	[15:0]	top_out,next_out;
	input		[15:0]	top_in,next_in;
	input					pop,push,w_tos,w_next,clk,rst;
	reg		[15:0]	top_out,next_out;
	reg		[15:0]	stack_ram[31:0]; // 32 word memory
	reg		[4:0]		tos_position,next_position;

	always @ (posedge clk or posedge rst) begin
		if (rst == 1) begin
			tos_position = 5'b0;
			next_position = 5'b11111;
		end else if (clk == 1) begin
			if (pop == 1) begin
				tos_position = tos_position - 1;
				next_position = next_position - 1;				
			end else if (push == 1) begin
				tos_position = tos_position + 1;
				next_position = next_position + 1;
			end
			if (w_tos == 1)
				stack_ram[tos_position] = top_in;
			if (w_next == 1)
				stack_ram[next_position] = next_in;
			top_out = stack_ram[tos_position];
			next_out = stack_ram[next_position];
		end
	end
endmodule 