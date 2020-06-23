`timescale 1ns / 1ps
`define op 31:26
`define funct 5:0
`define imm26 25:0
`define imm16 15:0
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define s 10:6
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:35:50 11/30/2019
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
	
	
	//////////////////////////// F //////////////////////////////
	//PC
	wire [31:0] PC;
	wire [31:0] nPC;
	wire PC_En;
	
	pc Pc(
		.clk(clk),
		.reset(reset),
		.En(PC_En),
		.PC(PC),
		.nPC(nPC)
		);
	
	//IM
	wire [31:0] Instr_F;
	
	im IM(
		.A(PC),
		.Instr(Instr_F)
		);
	
	//ADD4, ADD8
	wire [31:0] PC8_F = PC + 8;
	
	
	///////////////////////// D ////////////////////////////
	
	
	//FD
	wire [31:0] Instr_D;
	wire [31:0] PC8_D;
	wire FD_En;
	
	fd FD(
		.clk(clk),
		.reset(reset),
		.En(FD_En),
		.nInstr_D(Instr_F),
		.nPC8_D(PC8_F),
		.Instr_D(Instr_D),
		.PC8_D(PC8_D)
		);
	
	//CTRL_D
	wire [2:0] BranchSel;
	wire [1:0] EXTsel;
	wire [2:0] PcSel;
	
	ctrl CTRL_D(
		.Instr(Instr_D),
		.BranchSel(BranchSel),
		.EXTsel(EXTsel),
		.PcSel(PcSel)
		);
	
	//GRF
	wire [4:0] GRF_A1 = Instr_D[`rs];
	wire [4:0] GRF_A2 = Instr_D[`rt];
	wire [4:0] GRF_A3;
	wire [31:0] GRF_WD;
	wire [31:0] GRF_RD1;
	wire [31:0] GRF_RD2;
	wire GRF_WE;
	wire [31:0] PC_W;
	
	grf GRF(
		.clk(clk),
		.reset(reset),
		.WE(GRF_WE),
		.A1(GRF_A1),
		.A2(GRF_A2),
		.A3(GRF_A3),
		.WD(GRF_WD),
		.PC_W(PC_W),
		.RD1(GRF_RD1),
		.RD2(GRF_RD2)
		);
	
	//RS_D_MUX
	wire [31:0] RS_D_MUX_In1;
	wire [31:0] RS_D_MUX_In2;
	wire [31:0] RS_D_MUX_In3;
	wire [31:0] RS_D_MUX_In4;
	wire [31:0] RS_D_MUX_In5;
	wire [31:0] RS_D_MUX_In6;
	wire [2:0] RS_D_MUX_Op;
	wire [31:0] RS_D_MUX_Out;
	
	mux8 #(32) RS_D_MUX(
		.In0(GRF_RD1),
		.In1(RS_D_MUX_In1),
		.In2(RS_D_MUX_In2),
		.In3(RS_D_MUX_In3),
		.In4(RS_D_MUX_In4),
		.In5(RS_D_MUX_In5),
		.In6(RS_D_MUX_In6),
		.Op(RS_D_MUX_Op),
		.Out(RS_D_MUX_Out)
		);
	
	//RT_D_MUX
	wire [31:0] RT_D_MUX_In1;
	wire [31:0] RT_D_MUX_In2;
	wire [31:0] RT_D_MUX_In3;
	wire [31:0] RT_D_MUX_In4;
	wire [31:0] RT_D_MUX_In5;
	wire [31:0] RT_D_MUX_In6;
	wire [2:0] RT_D_MUX_Op;
	wire [31:0] RT_D_MUX_Out;
	
	mux8 #(32) RT_D_MUX(
		.In0(GRF_RD2),
		.In1(RT_D_MUX_In1),
		.In2(RT_D_MUX_In2),
		.In3(RT_D_MUX_In3),
		.In4(RT_D_MUX_In4),
		.In5(RT_D_MUX_In5),
		.In6(RT_D_MUX_In6),
		.Op(RT_D_MUX_Op),
		.Out(RT_D_MUX_Out)
		);
	
	//EXT
	wire [31:0] EXT_Out;

	ext EXT(
		.In(Instr_D[`imm16]),
		.Op(EXTsel),
		.Out(EXT_Out)
		);
	
	//npc
	wire [31:0] BranchA;
	wire [31:0] JumpA;
	
	npc NPC(
		.clk(clk),
		.pc(PC),
		.ImmB(EXT_Out),
		.ImmJ(Instr_D[`imm26]),
		.Cmp1(RS_D_MUX_Out),
		.Cmp2(RT_D_MUX_Out),
		.BranchOp(BranchSel),
		.grf(RS_D_MUX_Out),
		.Op(PcSel),
		.npc(nPC)
		);
	
	
	
	////////////////////////// E /////////////////////////////
	
	
	//DE
	wire DE_clr;
	wire [31:0] Instr_E;
	wire [31:0] RS_E;
	wire [31:0] RT_E;
	wire [31:0] EXT_E;
	wire [31:0] PC8_E;
	wire [31:0] s_E;
	
	de DE(
		.clk(clk),
		.reset(reset),
		.clr(DE_clr),
		.nInstr_E(Instr_D),
		.nRS_E(RS_D_MUX_Out),
		.nRT_E(RT_D_MUX_Out),
		.nEXT_E(EXT_Out),
		.nPC8_E(PC8_D),
		.ns_E(Instr_D[`s]),
		.Instr_E(Instr_E),
		.RS_E(RS_E),
		.RT_E(RT_E),
		.EXT_E(EXT_E),
		.PC8_E(PC8_E),
		.s_E(s_E)
		);
	
	//CTRL_E
	wire [3:0] ALUsel;
	wire ALU_A_MUXsel;
	wire ALU_B_MUXsel;
	wire [2:0] MDUsel;
	wire Start;
	wire MDU_RDsel;
	wire ALU_MDU_MUXsel;
	wire [1:0] RegDst;
	
	ctrl CTRL_E(
		.Instr(Instr_E),
		.ALUsel(ALUsel),
		.ALU_A_MUXsel(ALU_A_MUXsel),
		.ALU_B_MUXsel(ALU_B_MUXsel),
		.MDUsel(MDUsel),
		.Start(Start),
		.RegDst(RegDst),
		.MDU_RDsel(MDU_RDsel),
		.ALU_MDU_MUXsel(ALU_MDU_MUXsel)
		);
		
	//RS_E_MUX
	wire [31:0] RS_E_MUX_In1;
	wire [31:0] RS_E_MUX_In2;
	wire [31:0] RS_E_MUX_In3;
	wire [31:0] RS_E_MUX_In4;
	wire [2:0] RS_E_MUX_Op;
	wire [31:0] RS_E_MUX_Out;
	
	mux8 #(32) RS_E_MUX(
		.In0(RS_E),
		.In1(RS_E_MUX_In1),
		.In2(RS_E_MUX_In2),
		.In3(RS_E_MUX_In3),
		.In4(RS_E_MUX_In4),
		.Op(RS_E_MUX_Op),
		.Out(RS_E_MUX_Out)
		);
	
	//RT_E_MUX
	wire [31:0] RT_E_MUX_In1;
	wire [31:0] RT_E_MUX_In2;
	wire [31:0] RT_E_MUX_In3;
	wire [31:0] RT_E_MUX_In4;
	wire [2:0] RT_E_MUX_Op;
	wire [31:0] RT_E_MUX_Out;
	
	mux8 #(32) RT_E_MUX(
		.In0(RT_E),
		.In1(RT_E_MUX_In1),
		.In2(RT_E_MUX_In2),
		.In3(RT_E_MUX_In3),
		.In4(RT_E_MUX_In4),
		.Op(RT_E_MUX_Op),
		.Out(RT_E_MUX_Out)
		);
		
	//ALU_A_MUX
	wire [31:0] ALU_A_MUX_Out;
	
	mux2 #(32) ALU_A_MUX(
		.In0(RS_E_MUX_Out),
		.In1(s_E),
		.Op(ALU_A_MUXsel),
		.Out(ALU_A_MUX_Out)
		);
	
	//ALU_B_MUX
	wire [31:0] ALU_B_MUX_Out;
	
	mux2 #(32) ALU_B_MUX(
		.In0(RT_E_MUX_Out),
		.In1(EXT_E),
		.Op(ALU_B_MUXsel),
		.Out(ALU_B_MUX_Out)
		);
	
	//ALU
	wire [31:0] ALU_Out;
	
	alu ALU(
		.A(ALU_A_MUX_Out),
		.B(ALU_B_MUX_Out),
		.Op(ALUsel),
		.Out(ALU_Out)
		);
	
	//MDU
	wire [31:0] MDU_Out;
	wire Busy;
	
	mdu MDU(
		.clk(clk),
		.reset(reset),
		.Start(Start),
		.RDsel(MDU_RDsel),
		.A(RS_E_MUX_Out),
		.B(RT_E_MUX_Out),
		.Op(MDUsel),
		.Out(MDU_Out),
		.Busy(Busy)
		);
	
	//ALU_MDU_MUX
	wire [31:0] ALU_MDU_MUX_Out;
	
	mux2 #(32) ALU_MDU_MUX(
		.In0(ALU_Out),
		.In1(MDU_Out),
		.Op(ALU_MDU_MUXsel),
		.Out(ALU_MDU_MUX_Out)
		);
		
	//GRF_A3_MUX
	wire [4:0] A3_E;
	
	mux4 #(5) GRF_A3_MUX(
		.In0(Instr_E[`rd]),
		.In1(Instr_E[`rt]),
		.In2(5'd31),
		.Op(RegDst),
		.Out(A3_E)
		);
	
	/////////////////////////////// M //////////////////////////////////
	
	
	//EM
	wire [31:0] Instr_M;
	wire [31:0] RT_M;
	wire [31:0] ALU_M;
	wire [31:0] EXT_M;
	wire [31:0] PC8_M;
	wire [4:0] A3_M;
	
	em EM(
		.clk(clk),
		.reset(reset),
		.nInstr_M(Instr_E),
		.nRT_M(RT_E_MUX_Out),
		.nALU_M(ALU_MDU_MUX_Out),
		.nEXT_M(EXT_E),
		.nPC8_M(PC8_E),
		.nWBA_M(A3_E),
		.Instr_M(Instr_M),
		.RT_M(RT_M),
		.ALU_M(ALU_M),
		.EXT_M(EXT_M),
		.PC8_M(PC8_M),
		.WBA_M(A3_M)
		);
	
	//CTRL_M
	wire DM_WE;
	wire [1:0] StoreType;
	wire [2:0] LoadType;
	
	ctrl CTRL_M(
		.Instr(Instr_M),
		.DM_WE(DM_WE),
		.StoreType(StoreType),
		.LoadType(LoadType)
		);
	
	//RT_M_MUX
	wire [31:0] RT_M_MUX_In1;
	wire RT_M_MUX_Op;
	wire [31:0] RT_M_MUX_Out;
	
	mux2 #(32) RT_M_MUX(
		.In0(RT_M),
		.In1(RT_M_MUX_In1),
		.Op(RT_M_MUX_Op),
		.Out(RT_M_MUX_Out)
		);
	
	//DM
	wire [31:0] DM_RD;
	
	dm DM(
		.clk(clk),
		.reset(reset),
		.WE(DM_WE),
		.StoreType(StoreType),
		.LoadType(LoadType),
		.A(ALU_M),
		.WD(RT_M_MUX_Out),
		.PC_M(PC8_M - 8),
		.RD(DM_RD)
		);
	
	
	/////////////////////////////// W ///////////////////////////////
	
	
	//MW
	wire [31:0] Instr_W;
	wire [31:0] ALU_W;
	wire [31:0] DM_W;
	wire [31:0] EXT_W;
	wire [31:0] PC8_W;
	wire [4:0] A3_W;
	
	mw MW(
		.clk(clk),
		.reset(reset),
		.nInstr_W(Instr_M),
		.nALU_W(ALU_M),
		.nDM_W(DM_RD),
		.nEXT_W(EXT_M),
		.nPC8_W(PC8_M),
		.nWBA_W(A3_M),
		.Instr_W(Instr_W),
		.ALU_W(ALU_W),
		.DM_W(DM_W),
		.EXT_W(EXT_W),
		.PC8_W(PC8_W),
		.WBA_W(A3_W)
		);
	
	assign PC_W = PC8_W - 8;
	
	//CTRL_W
	wire [1:0] GRF_WD_MUXsel;
	
	ctrl CTRL_W(
		.Instr(Instr_W),
		.GRF_WD_MUXsel(GRF_WD_MUXsel),
		.GRF_WE(GRF_WE)
		);
	
	//GRF_WD_MUX
	wire [31:0] GRF_WD_MUX_Out;
	
	mux4 #(32) GRF_WD_MUX(
		.In0(ALU_W),
		.In1(DM_W),
		.In2(EXT_W),
		.In3(PC8_W),
		.Op(GRF_WD_MUXsel),
		.Out(GRF_WD_MUX_Out)
		);
		
	assign GRF_A3 = A3_W;
	assign GRF_WD = GRF_WD_MUX_Out;
	
	
	//////////////////////////// hazard /////////////////////////////////
	
	
	wire [2:0] RS_D_MUXsel;
	wire [2:0] RT_D_MUXsel;
	wire [2:0] RS_E_MUXsel;
	wire [2:0] RT_E_MUXsel;
	wire RT_M_MUXsel;
	wire Stall;
	
	hzd HZD(
		.IR_D(Instr_D),
		.IR_E(Instr_E),
		.WriteAddr_E(A3_E),
		.IR_M(Instr_M),
		.WriteAddr_M(A3_M),
		.IR_W(Instr_W),
		.Start(Start),
		.Busy(Busy),
		.RS_D_MUXsel(RS_D_MUXsel),
		.RT_D_MUXsel(RT_D_MUXsel),
		.RS_E_MUXsel(RS_E_MUXsel),
		.RT_E_MUXsel(RT_E_MUXsel),
		.RT_M_MUXsel(RT_M_MUXsel),
		.Stall(Stall)
		);
	
	//RS_D_MUX forward
	assign RS_D_MUX_In1 = EXT_E;
	assign RS_D_MUX_In2 = PC8_E;
	assign RS_D_MUX_In3 = ALU_M;
	assign RS_D_MUX_In4 = EXT_M;
	assign RS_D_MUX_In5 = PC8_M;
	assign RS_D_MUX_In6 = GRF_WD_MUX_Out;
	assign RS_D_MUX_Op = RS_D_MUXsel;
	
	//RT_D_MUX forward
	assign RT_D_MUX_In1 = EXT_E;
	assign RT_D_MUX_In2 = PC8_E;
	assign RT_D_MUX_In3 = ALU_M;
	assign RT_D_MUX_In4 = EXT_M;
	assign RT_D_MUX_In5 = PC8_M;
	assign RT_D_MUX_In6 = GRF_WD_MUX_Out;
	assign RT_D_MUX_Op = RT_D_MUXsel;
	
	//RS_E_MUX forward
	assign RS_E_MUX_In1 = ALU_M;
	assign RS_E_MUX_In2 = EXT_M;
	assign RS_E_MUX_In3 = PC8_M;
	assign RS_E_MUX_In4 = GRF_WD_MUX_Out;
	assign RS_E_MUX_Op = RS_E_MUXsel;
	
	//RT_E_MUX forward
	assign RT_E_MUX_In1 = ALU_M;
	assign RT_E_MUX_In2 = EXT_M;
	assign RT_E_MUX_In3 = PC8_M;
	assign RT_E_MUX_In4 = GRF_WD_MUX_Out;
	assign RT_E_MUX_Op = RT_E_MUXsel;
	
	//RT_M_MUX forward
	assign RT_M_MUX_In1 = GRF_WD_MUX_Out;
	assign RT_M_MUX_Op = RT_M_MUXsel;
	
	//stall
	assign PC_En = !Stall;
	assign FD_En = !Stall;
	assign DE_clr = Stall;
	
endmodule
