`timescale 1ns / 1ps

module core(mem_addr,mem_write,mem_data,clk,rst);
	output	[10:0]	mem_addr;
	output				mem_write;
	inout		[15:0]	mem_data;
	input					clk,rst;
	wire		[15:0]	rto_c,rto_d,con_mem;
	wire		[10:0]	new_addr;
	wire		[4:0]		new_instr;
	wire		[3:0]		alu_select;
	wire		[1:0]		d_select;
	wire					r_select,data_pop,data_push,dw_tos,dw_next,r_pop,r_push,rw_tos,mem_write;

	control c(.mem_addr(mem_addr),.r_out(rto_d),.alu_select(alu_select),.d_select(d_select),.r_select(r_select),
		.data_pop(data_pop),.data_push(data_push),.dw_tos(dw_tos),.dw_next(dw_next),
		.r_pop(r_pop),.r_push(r_push),.rw_tos(rw_tos),.r_in(rto_c),.mem_write(mem_write),
		.new_addr(new_addr),.new_instr(new_instr),.tos_or(tos_or),.clk(~clk),.rst(rst));
		
	data_path d(.r_tos(rto_c),.new_addr(new_addr),.new_instr(new_instr),.tos_or(tos_or),.mem_data(mem_data),.r_in(rto_d),
		.data_pop(data_pop),.data_push(data_push),.dw_tos(dw_tos),.dw_next(dw_next),
		.r_pop(r_pop),.r_push(r_push),.rw_tos(rw_tos),.w_mem(mem_write),
		.d_select(d_select),.r_select(r_select),.alu_select(alu_select),.clk(clk),.rst(rst));
endmodule 