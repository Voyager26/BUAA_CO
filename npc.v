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
	input clk,
	input [31:0] pc,
	input [31:0] ImmB,
	input [25:0] ImmJ,
	input [31:0] Cmp1,
	input [31:0] Cmp2,
	input [2:0] BranchOp,
	input [31:0] grf,
	input [2:0] Op,
	output reg [31:0] npc
    );
	reg [31:0] BranchA;
	initial begin
		BranchA = 0;
		npc = 32'h3000;
	end
	
	always @(*) begin
		
		case (BranchOp)
			0: BranchA = ($signed(Cmp1) == $signed(Cmp2)) ? (pc + (ImmB << 2)) : (pc + 4);		//beq
			1: BranchA = ($signed(Cmp1) != $signed(Cmp2)) ? (pc + (ImmB << 2)) : (pc + 4);		//bne
			2: BranchA = ($signed(Cmp1) <= 0) ? (pc + (ImmB << 2)) : (pc + 4);					//blez
			3: BranchA = ($signed(Cmp1) > 0) ? (pc + (ImmB << 2)) : (pc + 4);					//bgtz
			4: BranchA = ($signed(Cmp1) < 0) ? (pc + (ImmB << 2)) : (pc + 4);					//bltz
			5: BranchA = ($signed(Cmp1) >= 0) ? (pc + (ImmB << 2)) : (pc + 4);					//bgez
		endcase
		npc = (Op == 0) ? (pc+4):
				(Op == 1) ? BranchA :
				(Op == 2) ? {pc[31:28], ImmJ, 2'b00} :
				(Op == 3) ? grf : (pc+4);
	end
	
endmodule
