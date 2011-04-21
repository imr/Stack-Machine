`timescale 1ns / 1ps

module fib_tb;

	// Inputs
	reg clk;
	reg rst;
	reg b_control;
	reg [15:0] data_reg;

	// Outputs
	wire [10:0] mem_addr;
	wire mem_write;

	// Bidirs
	wire [15:0] mem_data;

	// Instantiate the Unit Under Test (UUT)
	core uut (mem_addr,mem_write,mem_data,clk,rst);
	buffer uub (mem_data,data_reg,b_control);

	initial begin
		clk = 0;
		rst = 0;
		b_control = 0;
		data_reg = 16'b0000000000000000;

		#2 rst = 1;
		#1 rst = 0;
		b_control = 1;
		#1  data_reg = 16'b0000111111111111;
		#10 data_reg = 16'b0000000000000000;
		#10 data_reg = 16'b0001011111111110;
		#10 data_reg = 16'b0000000000000001;		
		#10 data_reg = 16'b0001011111111101;
		#10 data_reg = 16'b0000000000001010;
		#10 data_reg = 16'b1101100000111111; //branch
		#10 data_reg = 16'b1010100000000000; //to return
		#10 data_reg = 16'b1000100000000000; //SWAP
		#10 data_reg = 16'b1001000000000000; //OVER
		#10 data_reg = 16'b0010100000000000; //+
		#10 data_reg = 16'b1011100000000000; //from return-
		#10 data_reg = 16'b1110000000000000; //exit
		#10 data_reg = 16'b1101100000111111; //branch 9
		#10 data_reg = 16'b1010100000000000; //to return
		#10 data_reg = 16'b1000100000000000; //SWAP
		#10 data_reg = 16'b1001000000000000; //OVER
		#10 data_reg = 16'b0010100000000000; //+
		#10 data_reg = 16'b1011100000000000; //from return-
		#10 data_reg = 16'b1110000000000000; //exit
		#10 data_reg = 16'b1101100000111111; //branch 8
		#10 data_reg = 16'b1010100000000000; //to return
		#10 data_reg = 16'b1000100000000000; //SWAP
		#10 data_reg = 16'b1001000000000000; //OVER
		#10 data_reg = 16'b0010100000000000; //+
		#10 data_reg = 16'b1011100000000000; //from return-
		#10 data_reg = 16'b1110000000000000; //exit
		#10 data_reg = 16'b1101100000111111; //branch 7
		#10 data_reg = 16'b1010100000000000; //to return
		#10 data_reg = 16'b1000100000000000; //SWAP
		#10 data_reg = 16'b1001000000000000; //OVER
		#10 data_reg = 16'b0010100000000000; //+
		#10 data_reg = 16'b1011100000000000; //from return-
		#10 data_reg = 16'b1110000000000000; //exit
		#10 data_reg = 16'b1101100000111111; //branch 6
		#10 data_reg = 16'b1010100000000000; //to return
		#10 data_reg = 16'b1000100000000000; //SWAP
		#10 data_reg = 16'b1001000000000000; //OVER
		#10 data_reg = 16'b0010100000000000; //+
		#10 data_reg = 16'b1011100000000000; //from return-
		#10 data_reg = 16'b1110000000000000; //exit
		#10 data_reg = 16'b1101100000111111; //branch 5
		#10 data_reg = 16'b1010100000000000; //to return
		#10 data_reg = 16'b1000100000000000; //SWAP
		#10 data_reg = 16'b1001000000000000; //OVER
		#10 data_reg = 16'b0010100000000000; //+
		#10 data_reg = 16'b1011100000000000; //from return-
		#10 data_reg = 16'b1110000000000000; //exit
		#10 data_reg = 16'b1101100000111111; //branch 4
		#10 data_reg = 16'b1010100000000000; //to return
		#10 data_reg = 16'b1000100000000000; //SWAP
		#10 data_reg = 16'b1001000000000000; //OVER
		#10 data_reg = 16'b0010100000000000; //+
		#10 data_reg = 16'b1011100000000000; //from return-
		#10 data_reg = 16'b1110000000000000; //exit
		#10 data_reg = 16'b1101100000111111; //branch 3
		#10 data_reg = 16'b1010100000000000; //to return
		#10 data_reg = 16'b1000100000000000; //SWAP
		#10 data_reg = 16'b1001000000000000; //OVER
		#10 data_reg = 16'b0010100000000000; //+
		#10 data_reg = 16'b1011100000000000; //from return-
		#10 data_reg = 16'b1110000000000000; //exit
		#10 data_reg = 16'b1101100000111111; //branch 2
		#10 data_reg = 16'b1010100000000000; //to return
		#10 data_reg = 16'b1000100000000000; //SWAP
		#10 data_reg = 16'b1001000000000000; //OVER
		#10 data_reg = 16'b0010100000000000; //+
		#10 data_reg = 16'b1011100000000000; //from return-
		#10 data_reg = 16'b1110000000000000; //exit
		#10 data_reg = 16'b1101100000111111; //branch 1
		#10 data_reg = 16'b1010100000000000; //to return
		#10 data_reg = 16'b1000100000000000; //SWAP
		#10 data_reg = 16'b1001000000000000; //OVER
		#10 data_reg = 16'b0010100000000000; //+
		#10 data_reg = 16'b1011100000000000; //from return-
		#10 data_reg = 16'b1110000000000000; //exit		
		#10 data_reg = 16'b1101100000111111; //branch
		#10 data_reg = 16'b1001100000000000; //drop
		#10 data_reg = 16'b0001111111110000;
		#6 b_control = 0;
	end
	
	always begin
		#5 clk = 1;
		#5 clk = 0;
	end
      
endmodule 