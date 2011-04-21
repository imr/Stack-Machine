`timescale 1ns / 1ps

module ALU_tb;

	// Inputs
	reg [15:0] tos;
	reg [15:0] next;
	reg [3:0] select;

	// Outputs
	wire [15:0] o_tos;
	wire [15:0] o_next;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.o_tos(o_tos), 
		.o_next(o_next), 
		.tos(tos), 
		.next(next), 
		.select(select)
	);

	initial begin
		// Initialize Inputs
		tos = 0;
		next = 0;
		select = 0;

		#5		select = 4'b1001;
		#5		tos = 16'b1111111111111111;
				next = 16'b0000000000111111;
		#5		select = 4'b0001;
		#5		select = 4'b0010;
		#5		select = 4'b0011;
		#5		select = 4'b0110;
		#5		select = 4'b0111;
		#5		select = 4'b1000;
		#5		select = 4'b1010;
				tos = 16'b1100110011001100;
	end
      
endmodule

