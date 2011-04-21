`timescale 1ns / 1ps

module data_path(r_tos,new_addr,new_instr,tos_or,mem_data,r_in,data_pop,data_push,dw_tos,dw_next,
	r_pop,r_push,rw_tos,w_mem,d_select,r_select,alu_select,clk,rst);
	output	[15:0]	r_tos;
	output	[10:0]	new_addr;
	output	[4:0]		new_instr;
	output				tos_or;
	inout		[15:0]	mem_data;
	input		[15:0]	r_in;
	input					data_pop,data_push,dw_tos,dw_next,r_pop,r_push,rw_tos,w_mem,r_select,clk,rst;
	input		[1:0]		d_select;
	input		[3:0]		alu_select;
	wire		[15:0]	data_tos,data_next,dtos_in,dnext_in,ALU_out,rtos_in,rnext_in,r_next,r_tos;
	wire		[3:0]		alu_select;
	wire		[1:0]		d_select;
	reg		[15:0]	ro_tos;
	reg		[10:0]	new_addr;
	reg		[4:0]		new_instr;
	reg					tos_or;
	
	stack data_stack(data_tos,data_next,dtos_in,dnext_in,data_pop,data_push,dw_tos,dw_next,clk,rst);
	stack return_stack(r_tos,r_next,rtos_in,rnext_in,r_pop,r_push,rw_tos,1'b0,clk,rst);

	ALU ALU1(ALU_out,dnext_in,data_tos,data_next,alu_select);

	mux2_1 r_mux(rtos_in,r_in,data_tos,r_select);
	mux4_2 d_mux(dtos_in,mem_data,r_tos,ALU_out,r_tos - 1'b1,d_select);

	buffer mem_buf(mem_data,data_tos,w_mem);

	always @(r_tos)
		ro_tos = r_tos;

	always @(data_tos)
		tos_or = |(data_tos);
		
	always @(mem_data) begin
		new_instr = mem_data[15:11];
		new_addr = mem_data[10:0];
	end
endmodule 