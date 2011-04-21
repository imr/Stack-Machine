`timescale 1ns / 1ps

module mux2_1(out,A,B,select);
	output	[15:0]	out;
	input		[15:0]	A,B;
	input					select;
	reg		[15:0]	out;
	
	always @ (select or A or B) begin
		if (select == 1'b1) out = A;
		else out = B;
	end
endmodule 