`timescale 1ns / 1ps

module mux4_2(out,A,B,C,D,select);
	output	[15:0]	out;
	input		[15:0]	A,B,C,D;
	input		[1:0]		select;
	reg		[15:0]	out;
	
	always @ (A or B or C or D or select) begin
		case (select)
			2'b11:	out = A;
			2'b10:	out = B;
			2'b01:	out = C;
			2'b00:	out = D;
		endcase
	end
endmodule
