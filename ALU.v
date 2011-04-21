`timescale 1ns / 1ps

module ALU(o_tos,o_next,tos,next,select);
	output	[15:0]	o_tos,o_next;
	input		[15:0]	tos,next;
	input		[3:0]		select;
	reg		[15:0]	o_tos,o_next;
	
	always @ (select or tos or next) begin
		case (select)
			4'b0000:	begin 
							o_tos = tos;
							o_next = next;
						end
			4'b0001:	o_tos = tos + next;
			4'b0010:	o_tos = tos - next;
			4'b0011:	o_tos = tos * next;
			//4'b0100:	o_tos = tos / next;
			4'b0101:	begin
							//o_tos = tos / next;
							//o_next = tos % next;
						end
			4'b0110:	o_tos = tos & next;
			4'b0111:	o_tos = tos | next;
			4'b1000:	o_tos = tos ^ next;
			4'b1001: if (tos == next) o_tos = 16'b1111111111111111; else o_tos = 16'b0000000000000000;
			4'b1010:	if (tos > next) o_tos = 16'b1111111111111111; else o_tos = 16'b0000000000000000;
			4'b1011:	if (tos < next) o_tos = 16'b1111111111111111; else o_tos = 16'b0000000000000000;
			4'b1100: o_tos = ~tos;
			4'b1101:	begin
							o_tos = next;
							o_next = tos;
						end
			
		endcase
	end
endmodule
