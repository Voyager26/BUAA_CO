`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:56 11/20/2019 
// Design Name: 
// Module Name:    ctl2 
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
module ctl2(
    input [5:0] opcode,
    input [5:0] func,
    output reg [1:0] RegDst,
    output reg RegWrite,
    output reg AluSrc,
    output reg MemToReg,
    output reg MemWrite,
    output reg NpcSel,
    output reg [3:0] ExtOp,
    output reg [3:0] AluOp,
    output reg J,
    output reg Jal,
    output reg Jr,
    output reg tmp
    );
	wire addu;
	wire subu;
	wire ori;
	wire lw;
	wire sw;
	wire beq;
	wire lui;
	wire j;
	wire jal;
	wire jr;
	wire jalr;
	assign addu = !opcode[5] && !opcode[4] && !opcode[3] && !opcode[2] && !opcode[1] && !opcode[0] && func[5] && !func[4] && !func[3] && !func[2] && !func[1] && func[0];
	assign subu = !opcode[5] && !opcode[4] && !opcode[3] && !opcode[2] && !opcode[1] && !opcode[0] && func[5] && !func[4] && !func[3] && !func[2] && func[1] && func[0];
	assign jr = !opcode[5] && !opcode[4] && !opcode[3] && !opcode[2] && !opcode[1] && !opcode[0] && !func[5] && !func[4] && func[3] && !func[2] && !func[1] && !func[0];
	assign ori = !opcode[5] && !opcode[4] && opcode[3] && opcode[2] && !opcode[1] && opcode[0];
	assign lw = opcode[5] && !opcode[4] && !opcode[3] && !opcode[2] && opcode[1] && opcode[0];
	assign sw = opcode[5] && !opcode[4] && opcode[3] && !opcode[2] && opcode[1] && opcode[0];
	assign beq = !opcode[5] && !opcode[4] && !opcode[3] && opcode[2] && !opcode[1] && !opcode[0];
	assign lui = !opcode[5] && !opcode[4] && opcode[3] && opcode[2] && opcode[1] && opcode[0];
	assign j = !opcode[5] && !opcode[4] && !opcode[3] && !opcode[2] && opcode[1] && !opcode[0];
	assign jal = !opcode[5] && !opcode[4] && !opcode[3] && !opcode[2] && opcode[1] && opcode[0];
	assign bne = !opcode[5] && !opcode[4] && !opcode[3] && opcode[2] && !opcode[1] && opcode[0];
	assign jalr = !opcode[5] && !opcode[4] && !opcode[3] && !opcode[2] && !opcode[1] && !opcode[0] && !func[5] && !func[4] && func[3] && !func[2] && !func[1] && func[0];
	always@(*)begin
		RegDst[1] = jal;
		RegDst[0] = addu || subu || jalr;
		RegWrite = addu || subu || ori || lw || lui || jal || jalr;
		AluSrc = ori || lw || sw || lui;
		MemToReg = lw;
		MemWrite = sw;
		NpcSel = beq || bne;
		ExtOp[3] = 0;
		ExtOp[2] = 0;
		ExtOp[1] = lui || beq || bne;
		ExtOp[0] = lw || sw || beq || bne;
		AluOp[3] = 0;
		AluOp[2] = bne;
		AluOp[1] = ori || beq;
		AluOp[0] = subu || beq;
		J = j || jal;
		Jal = jal || jalr;
		Jr = jr || jalr;
		tmp = tmp;
	end
endmodule
