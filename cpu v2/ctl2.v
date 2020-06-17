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
    input [5:0] Op,
    input [5:0] Funct,
	 //D
	 output reg J,
    output reg Jal,
    output reg Jr,
	 output reg [2:0] NpcSel,
    output reg [3:0] ExtOp,
	 //E
	 output reg [3:0] AluOp,
	 output reg AluSrc,
	 output reg [1:0] RegDst,
	 //M
	 output reg MemWrite,
	 //W
    output reg [1:0] MemToReg,
	 output reg RegWrite,
    
	 output reg tmp
    );
	 
	wire addu = (Op == 6'b000000 && Funct == 6'b100001);
	wire subu = (Op == 6'b000000 && Funct == 6'b100011);
	wire jr = (Op == 6'b000000 && Funct == 6'b001000);
	wire nop = (Op == 6'b000000 && Funct == 6'b000000);
	wire jalr = (Op == 6'b000000 && Funct == 6'b001001);
	wire rotr = (Op == 6'b000000 && Funct == 6'b000010);
	wire clz = (Op == 6'b011100);
	wire ori = (Op == 6'b001101);
	wire lw = (Op == 6'b100011);
	wire sw = (Op == 6'b101011);
	wire beq = (Op == 6'b000100);
	wire blez = (Op == 6'b000110);
	wire bgezal = (Op == 6'b000001);
	wire lui = (Op == 6'b001111);
	wire j = (Op == 6'b000010);
	wire jal = (Op == 6'b000011);
	
	always@(*)begin
		//0:rt 1:rd 2:$31
		RegDst[1] = jal || bgezal;				//31
		RegDst[0] = addu || subu || jalr || clz || rotr;	//rd
		RegWrite = addu || subu || ori || lw || lui || jal || jalr || bgezal || clz || rotr;
		AluSrc = ori || lw || sw || lui;
		//0:aluresult 1:dmOut 2:PC+8 3:0
		MemToReg[1] = jal || jalr || bgezal;				
		MemToReg[0] = lw;
		MemWrite = sw;
		//000:not B  001:beq 010:bgezal 011:blez 100:blezalr
		NpcSel[2] = 0;
		NpcSel[1] = bgezal || blez;
		NpcSel[0] = beq || blez;
		//0:32'b0 1:0扩展 2:符号扩展 3：至高16位 4:左移2位有符号扩展
		ExtOp[3] = 0;
		ExtOp[2] = beq || bgezal || blez;
		ExtOp[1] = lw || sw || lui ;
		ExtOp[0] = lui || ori;
		//0:+ 1:- 2:| 3:clz
		AluOp[3] = 0;
		AluOp[2] = rotr;
		AluOp[1] = ori || clz;
		AluOp[0] = subu || clz;
		
		J = j || jal;
		Jal = jal || jalr;
		Jr = jr || jalr;
		tmp = tmp;
	end
endmodule
