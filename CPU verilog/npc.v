`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:06:03 11/18/2019 
// Design Name: 
// Module Name:    npc 
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
module npc(
	 input [31:0] pc,
    input npc_sel,
	 input equal,
    input jump,
    input clk,
    input reset,
	 input jr,
	 input [31:0] gpr,
    input [31:0] imm32,
	 input [25:0] imm26,
    output reg [31:0] npc,
	 output [31:0] jarpc
    );
	assign jarpc = pc + 4;
	always@(*) begin
			if(jump)
				npc = {pc[31:28], imm26, 2'b00};
			else if(npc_sel && equal)
				npc = pc + 4 + imm32;
			else if(jr)
				npc = gpr;
			else 
				npc = pc + 4;
	end
endmodule
