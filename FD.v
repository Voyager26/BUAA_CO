`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:45:30 11/30/2019 
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
module fd(
	input clk,
	input reset,
	input En,
	input [31:0] nInstr_D,
	input [31:0] nPC8_D,
	output reg [31:0] Instr_D,
	output reg [31:0] PC8_D
    );
	initial begin
		Instr_D = 0;
		PC8_D = 32'h3008;
	end
	
	always @(posedge clk) begin
		if (reset) begin
			Instr_D = 0;
			PC8_D = 32'h3008;
		end
		else if (En) begin
			Instr_D = nInstr_D;
			PC8_D = nPC8_D;
		end
	end

endmodule
