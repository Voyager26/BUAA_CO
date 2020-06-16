`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:24:35 11/18/2019 
// Design Name: 
// Module Name:    dm_4kb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dm_4kb(
	 input [31:0] pc,
    input [31:0] DataAddress,
    input MemWrite,
    input reset,
    input [31:0] DataIn,
	 input clk,
    output [31:0] DataOut
    );
	wire [11:2] address;			
	assign address = DataAddress[11:2];	//address save as word
	reg[31:0] dm[1023:0];			//32bit*1024字的数据存储器
	integer i;
	initial begin
			for(i = 1; i < 1024; i = i + 1) dm[i] <= 0;//初始化数据存储器为0
	end
	assign DataOut = dm[address];		//output 
	
	always@(posedge clk) begin
		if(reset) begin
			for(i = 1; i < 1024; i = i + 1) 
				dm[i] <= 0;
		end
		else if(MemWrite) begin
			dm[address] <= DataIn;
			$display("@%h: *%h <= %h",pc, DataAddress, DataIn);
		end
	end

endmodule
