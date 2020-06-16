`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:09:56 11/17/2019 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
	//npc
	wire [31:0] npc;	//当前pc
   wire NPc_Sel;		//选择是否执行分支Pc+4+offset
   wire jump;			//选择是否j跳转
	wire jr;				//选择是否jr跳转
	wire [31:0] gpr;	//来自寄存器的pc
	//pc
	wire [31:0] Pc;
	//im
   wire [31:0] imm32;
	wire [25:0] imm26;
	wire [15:0] imm16;
   wire [31:0] Npc;		
	wire [31:0] jarpc;
	wire [5:0] opcode;
	wire [31:0] op;
   wire [4:0] rs;
   wire [4:0] rt;
   wire [4:0] rd;
   wire [4:0] shamt;
   wire [5:0] func;
	//ctl
	wire [1:0] Reg_Dst;	//写寄存器的目标寄存器号来源:0-rt 1-rd
   wire Reg_Write;		//寄存器写入使能端
   wire Alu_Src;			//alu操作数选择
   wire MemToReg;			//是否从mem到reg
   wire Mem_Write;		//mem写入使能端
   wire [3:0] Ext_Op;
   wire [3:0] Alu_Op;
   wire tmp;
	//dm
	wire [31:0] DataOut;
	//grf
	wire [31:0] rd1;
	wire [31:0] rd2;
	//alu
	wire [31:0] Aluresult;
	wire equal;
	//ext
	wire [31:0] EXTout;
	//mux
	wire [31:0] DataToDM;
	wire [31:0] RegData;
	wire [31:0] DataToReg;
	wire [31:0] DataToALU;
	wire [31:0] MemToRegData;
	wire [4:0] RegAddress;
	pc 			PC(npc[31:0], clk, reset, Pc);
	npc 			nextPc(Pc[31:0], NPc_Sel, equal, jump, clk, reset, jr, rd1, EXTout, imm26, npc[31:0], jarpc[31:0]);
	im_4kb 		im(Pc[31:0], opcode[5:0], rs[4:0], rt[4:0], rd[4:0], shamt[4:0], func[5:0], imm16[15:0], imm26[25:0], op);
	ctl2 			control(opcode[5:0], func[5:0], Reg_Dst[1:0], Reg_Write, Alu_Src, MemToReg, Mem_Write, NPc_Sel, Ext_Op[3:0], Alu_Op[3:0], jump, jal, jr, tmp);	
	EXT 			Ext(imm16[15:0], Ext_Op, EXTout);
	mux5 			regdst(Reg_Dst[1:0], rt[4:0], rd[4:0], 5'b11111, RegAddress[4:0]);	//rt\rd\31 
	grf 			Grf(rs[4:0], rt[4:0], RegAddress[4:0], DataToReg[31:0], clk, reset, Reg_Write, rd1[31:0], rd2[31:0], Pc);
	mux32in2 	MuxALUSRC(Alu_Src, rd2[31:0], EXTout[31:0], DataToALU[31:0]);
	alu 			ALU(rd1[31:0], DataToALU[31:0], Alu_Op[3:0], Aluresult[31:0], equal);
	dm_4kb 		DM(Pc, Aluresult, Mem_Write, reset, rd2, clk, DataOut);
	mux32in2 	MuxALUOrMem(MemToReg, Aluresult[31:0], DataOut, RegData);
	mux32in2		MuxRegData(jal, RegData, jarpc, DataToReg);
	
endmodule
