`timescale 1ns / 1ps

module control(mem_addr,r_out,alu_select,d_select,r_select,data_pop,data_push,dw_tos,dw_next,r_pop,r_push,rw_tos,r_in,mem_write,new_addr,new_instr,tos_or,clk,rst);

	output	[10:0]	mem_addr;
	output	[15:0]	r_out;
	output	[3:0]		alu_select;
	output	[1:0]		d_select;
	output				r_select,data_pop,data_push,dw_tos,dw_next,r_pop,r_push,rw_tos,mem_write;
	input		[15:0]	r_in;
	input		[10:0]	new_addr;
	input		[4:0]		new_instr;
	input					tos_or,clk,rst;
	reg		[15:0]	r_out;
	reg		[10:0]	mem_addr,next_addr,load_return;
	reg		[4:0]		instruction;
	reg		[3:0]		alu_select;
	reg		[1:0]		d_select;
	reg					r_select,data_pop,data_push,dw_tos,dw_next,r_pop,r_push,rw_tos,mem_write,double;

	always @ (posedge clk or posedge rst) begin
			data_pop = 0;
			data_push = 0;
			dw_tos = 0;
			dw_next = 0;
			r_pop = 0;
			r_push = 0;
			rw_tos = 0;	
			mem_write = 0;
			alu_select = 4'b0;
			r_select = 0;
		if (rst == 1) begin
			next_addr = 11'b0;
			instruction = 5'b0;
			double = 0;
			mem_addr = 11'b0;
		end else if (double == 1'b0) begin
			instruction = new_instr;
			next_addr = mem_addr + 11'b1;
			case (instruction)
				5'b00000: data_pop = 0;//nop
				5'b00001: //load top
					begin
						double = 1;
						next_addr = new_addr;
						load_return = mem_addr;
						d_select = 2'b11;
						dw_tos = 1;
					end
				5'b00010: //load push
					begin
						double = 1;
						next_addr = new_addr;
						load_return = mem_addr;
						d_select = 2'b11;
						data_push = 1;
						dw_tos = 1;
					end
				5'b00011: //store top
					begin
						double = 1;
						next_addr = new_addr;
						load_return = mem_addr;
						mem_write = 1;
					end
				5'b00100: //store pop
					begin
						double = 1;
						next_addr = new_addr;
						load_return = mem_addr;
						data_pop = 1;
						mem_write = 1;
					end
				5'b00101: //signed add
					begin
						data_pop = 1;
						alu_select = 4'b0001;
						d_select = 2'b01;
						dw_tos = 1;
					end
				5'b00110: //signed subtract
					begin
						data_pop = 1;
						alu_select = 4'b0010;
						d_select = 2'b01;
						dw_tos = 1;
					end
				5'b00111: //signed multiply
					begin
						data_pop = 1;
						alu_select = 4'b0011;
						d_select = 2'b01;
						dw_tos = 1;
					end
				5'b01000: //signed divide -- not used
					begin
						data_pop = 1;
						alu_select = 4'b0100;
						d_select = 2'b01;
						dw_tos = 1;
					end
				5'b01001: //signed divide and mod -- not used
					begin
						data_pop = 1;
						dw_tos = 1;
						dw_next = 1;
						d_select = 2'b01;
						alu_select = 4'b0101;
					end
				5'b01010: //bitwise and
					begin
						data_pop = 1;
						dw_tos = 1;
						d_select = 2'b01;
						alu_select = 4'b0110;
					end
				5'b01011: //bitwise or
					begin
						data_pop = 1;
						dw_tos = 1;
						d_select = 2'b01;
						alu_select = 4'b0111;
					end
				5'b01100: //bitwise XOR
					begin
						data_pop = 1;
						dw_tos = 1;
						d_select = 2'b01;
						alu_select = 4'b1000;
					end
				5'b01101: //compare
					begin
						data_pop = 1;
						dw_tos = 1;
						d_select = 2'b01;
						alu_select = 4'b1001;
					end
				5'b01110: //greater than
					begin
						data_pop = 1;
						dw_tos = 1;
						d_select = 2'b01;
						alu_select = 4'b1010;
					end
				5'b01111: //less than
					begin
						data_pop = 1;
						dw_tos = 1;
						d_select = 2'b01;
						alu_select = 4'b1011;
					end		
				5'b10000: //bitwise not
					begin
						dw_tos = 1;
						d_select = 2'b01;
						alu_select = 4'b1100;
					end
				5'b10001: //swap
					begin
						dw_tos = 1;
						dw_next = 1;
						d_select = 2'b01;
						alu_select = 4'b1101;
					end
				5'b10010: //over
					begin
						alu_select = 4'b1101;
						d_select = 2'b01;
						data_push = 1;
						dw_tos = 1;
					end
				5'b10011: //drop
					begin
						data_pop = 1;
					end
				5'b10100: //duplicate
					begin
						data_push = 1;
						dw_tos = 1;
						d_select = 2'b01;
						alu_select = 4'b0000;
					end
				5'b10101: //to return stack
					begin
						data_pop = 1;
						r_push = 1;
						rw_tos = 1;
						r_select = 0;
					end
				5'b10110: //from return stack
					begin
						data_push = 1;
						dw_tos = 1;
						r_pop = 1;
						d_select = 2'b10;
					end
				5'b10111: //from return stack-
					begin
						d_select = 2'b00;
						data_push = 1;
						dw_tos = 1;
						r_pop = 1;
					end
				5'b11000: //copy return stack
					begin
						data_push = 1;
						dw_tos = 1;
						d_select = 2'b10;
					end
				5'b11001: //branch if zero
					begin
						data_pop = 1;
						if (tos_or == 0) begin
							r_out = {5'b00000,mem_addr};
							r_push = 1;
							rw_tos = 1;
							r_select = 1;
							next_addr = new_addr;
						end
					end
				5'b11010: //branch if nonzero
					begin
						data_pop = 1;
						if (tos_or == 1) begin
							r_out = {5'b00000,mem_addr};
							r_push = 1;
							rw_tos = 1;
							r_select = 1;
							next_addr = new_addr;
						end
					end
				5'b11011: //branch if nonzero, leave top
					if (tos_or == 1'b1) begin
						r_out = {5'b00000,mem_addr};
						r_select = 1;
						r_push = 1;
						rw_tos = 1;
						next_addr = new_addr;
					end
				5'b11100: //exit to previous instruction
					begin
						next_addr = r_in[10:0];
						r_pop = 1;
					end
				5'b11101: //exit to previous+1 instruction
					begin
						next_addr = r_in[10:0] + 1'b1;
						r_pop = 1;
					end
			endcase
			mem_addr = next_addr;
		end else begin
			double = 0;
			next_addr = load_return + 1'b1;
			mem_addr = next_addr;
		end
	end
endmodule 