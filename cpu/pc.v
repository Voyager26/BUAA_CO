`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:11:09 11/19/2019 
// Design Name: 
// Module Name:    pc 
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
    input [31:0] NPc,
    input clk,
    input reset,
	 input en,
    output reg [31:0] Pc
    );
	initial
		begin
			Pc = 32'h0000_3000;	
		end
	always@(posedge clk)
		begin
			if(reset) Pc = 32'h0000_3000;
			else if(en) Pc = NPc;
		end

endmodule
