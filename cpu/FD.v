`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:22:08 11/24/2019 
// Design Name: 
// Module Name:    FD 
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
module Fd(
    input [31:0] IR_F,
    input [31:0] PC4_F,
	 input [31:0] PC8_F,
    input en,
    input clk,
	 input reset,
    input clr,
    output reg [31:0] PC4_D,
	 output reg [31:0] PC8_D,
    output reg [31:0] IR_D
    );
	initial begin
		IR_D = 0;
		PC4_D = 32'h3004;
		PC8_D = 32'h3008;
	end
	
	always @(posedge clk) begin
		if (reset) begin
			IR_D = 0;
			PC4_D = 32'h3004;
			PC8_D = 32'h3008;
		end
		else if (en) begin
			IR_D = IR_F;
			PC4_D = PC4_F;
			PC8_D = PC8_F;
		end
	end
	

endmodule
