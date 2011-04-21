`timescale 1ns / 1ps

module buffer(out,in,enable);
	output	[15:0]	out;
	input		[15:0]	in;
	input					enable;
	reg		[15:0]	out;
	
	always @ (in or enable)
		if (enable == 1) out = in; else out = 16'bz;

endmodule
