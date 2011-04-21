`timescale 1ns / 1ps

module stack_tb;

	// Inputs
	reg [15:0] top_in;
	reg [15:0] next_in;
	reg pop;
	reg push;
	reg w_tos;
	reg w_next;
	reg clk;
	reg rst;

	// Outputs
	wire [15:0] top_out;
	wire [15:0] next_out;
	// Instantiate the Unit Under Test (UUT)
	stack uut (
		.top_out(top_out), 
		.next_out(next_out), 
		.top_in(top_in), 
		.next_in(next_in), 
		.pop(pop), 
		.push(push), 
		.w_tos(w_tos), 
		.w_next(w_next), 
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		top_in = 0;
		next_in = 0;
		pop = 0;
		push = 0;
		w_tos = 0;
		w_next = 0;
		clk = 0;
		rst = 0;

		#2 rst = 1;
		#1 rst = 0;
		#20 top_in = 16'b1100110011001100;
		w_tos = 1;
		#10 top_in = 16'b0011001100110011;
		push = 1;
		#10 top_in = 16'b0011100110100101;
		#10 top_in = 16'b1011001110001111;
		#10 w_tos = 0;
		pop = 1;
		#10 next_in = 16'b1111111100000000;
		w_next = 1;
		pop = 0;
	end
	
	always begin
		#5 clk = 1;
		#5 clk = 0;
	end
      
endmodule

