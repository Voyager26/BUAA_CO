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
module NPC(
	 input [31:0] pc4,
    input [2:0] npc_sel,
	 input [31:0] cmp1,
	 input [31:0] cmp2,
    input jump,
	 input jr,
	 input [31:0] gpr,
    input [31:0] imm32,
	 input [25:0] imm26,
    output reg [31:0] npc,
	 output reg AddNop
    );
	 wire [31:0] pc = pc4 - 4;
	 initial begin
		npc = 32'h0000_3000;
		AddNop = 0;
	 end
	always@(*) begin
			if(jump) begin
				npc = {pc[31:28], imm26, 2'b00};
				AddNop = 0;
			end
			else if(npc_sel == 3'b001 && cmp1 == cmp2) begin
				npc = pc + imm32;
				AddNop = 0;
			end
			else if(npc_sel == 3'b010 && $signed(cmp1) >= 0) begin
				npc = pc + imm32;
				AddNop = 0;
			end
			else if(npc_sel == 3'b011 && $signed(cmp1) <= 0) begin
				npc = pc + imm32;
				AddNop = 0;
			end
			else if(npc_sel == 3'b100 && $signed(cmp1) <= 0) begin
				npc = pc + imm32;
				AddNop = 1;
			end
			else if(jr) begin
				npc = gpr;
				AddNop = 0;
			end
			else begin
				npc = pc4;
				AddNop = 0;
			end	
	end
endmodule
