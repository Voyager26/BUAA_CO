`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:18:21 11/20/2019 
// Design Name: 
// Module Name:    PC 
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
module pc(
	input clk,
	input reset,
	input En,
	input [31:0] nPC,
	output reg [31:0] PC
    );
	initial begin
		PC = 32'h3000;
	end
	always @(posedge clk) begin
		if (reset)
			PC = 32'h3000;
		else if (En)
			PC = nPC;
	end
	
endmodule
