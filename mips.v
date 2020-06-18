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
	 
///////////HZD
	wire PCEnD;
	wire EnD;
	wire FlushD;
	wire [2:0] ForwardRtD;
	wire [2:0] ForwardRsD;
	wire FlushE;
	wire [2:0] ForwardRtE;
	wire [2:0] ForwardRsE;
	wire DMWrW;
	wire RFWrE;
	wire DMWrM;
	wire RFWrM;
	wire RFWrW;
	wire Rs_D;
	wire Rt_D;
	wire Rs_E;
	wire Rt_E;
	wire Dst_E;
	wire Dst_M;
	wire Dst_W;
	wire ForwardDM;
	
	
///////////////////////////////// F ////////////////////////////////////////////
	//PC
	wire [31:0] PC_F;
	wire [31:0] nPC_F;
	wire PC_En = PCEnD;
	pc Pc(nPC_F, clk, reset, PC_En, PC_F);
	/*
	 input [31:0] NPc,
    input clk,
    input reset,
	 input en,
    output reg [31:0] Pc
	*/
	
	//IM
	wire [31:0] IR_F;
	im_4kb im(PC_F, IR_F);
	/*
	 input [31:0] Pc,
    output reg [31:0] IR
	*/
	
	//ADD4, ADD8
	wire [31:0] PC4_F = PC_F + 4;
	wire [31:0] PC8_F = PC_F + 8;
		
///////////////////////////// D /////////////////////////////////////////
	//Regsiter FD
	wire [31:0] PC4_D;
	wire [31:0] PC8_D;
   wire [31:0] IR_D;
	Fd fd(IR_F, PC4_F, PC8_F, EnD, clk, reset, FlushD, PC4_D, PC8_D, IR_D);
	/*
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
	*/
	
	 //decodeIR
    wire [5:0] opcode_D;
    wire [4:0] rs_D;
    wire [4:0] rt_D;
    wire [4:0] rd_D;
    wire [4:0] shamt_D;
    wire [5:0] func_D;
    wire [15:0] imm16_D;
    wire [25:0] imm26_D;
	decoder decoderD(IR_D, opcode_D, rs_D, rt_D, rd_D, shamt_D, func_D, imm16_D, imm26_D);
	/*
	 input [31:0] IR,
    output [5:0] opcode,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] shamt,
    output [5:0] func,
    output [15:0] imm16,
    output [25:0] imm26
	*/
	
	//grf
	wire [4:0] grf_a3;
	wire [31:0] grf_WD;
	wire RegWrite;
	wire [31:0] RD1_D;
	wire [31:0] RD2_D;
	wire [31:0] WPC;
	GRF grf(rs_D, rt_D, grf_a3, grf_WD, clk, reset, RegWrite, RD1_D, RD2_D, WPC);
	/*
	 input [4:0] a1,
    input [4:0] a2,
    input [4:0] a3,
    input [31:0] WriteData,
    input clk,
    input reset,
    input regWrite,
    output [31:0] RD1,
    output [31:0] RD2,
    input [31:0] WPC
	*/
	
	//ext
	wire [3:0] ext_op_D;
	wire [31:0] imm32_D;
	EXT ext(imm16_D, ext_op_D, imm32_D);
	/*
	 input [15:0] imm16,
    input [3:0] ext_op,
    output reg [31:0] imm32
	*/
	
	//MUX_RsD
	wire [31:0] fowardRs_D1;
	wire [31:0] fowardRs_D2;
	wire [31:0] fowardRs_D3;
	wire [31:0] fowardRs_D4;
	wire [31:0] fowardRs_D5;
	wire [31:0] fowardRs_D6;
	wire [31:0] fowardRs_D7;
	wire [31:0] V1_D;
	mux32in8 mux_Rs_D(ForwardRsD, RD1_D, fowardRs_D1, fowardRs_D2, fowardRs_D3, fowardRs_D4, fowardRs_D5, fowardRs_D6, fowardRs_D7, V1_D);
	/*
	  input [1:0]ctl,
	  input [31:0] in0,	
	  input [31:0] in1, 	
	  input [31:0] in2,	
	  input [31:0] in3,		
	  output reg [31:0] out
	*/
	
	//MUX_RtD
	wire [31:0] fowardRt_D1;
	wire [31:0] fowardRt_D2;
	wire [31:0] fowardRt_D3;
	wire [31:0] fowardRt_D4;
	wire [31:0] fowardRt_D5;
	wire [31:0] fowardRt_D6;
	wire [31:0] fowardRt_D7;
	wire [31:0] V2_D;
	mux32in8 mux_Rt_D(ForwardRtD, RD2_D, fowardRt_D1, fowardRt_D2, fowardRt_D3, fowardRt_D4, fowardRt_D5, fowardRt_D6, fowardRt_D7, V2_D);
	/*
	  input [1:0]ctl,
	  input [31:0] in0,	
	  input [31:0] in1, 	
	  input [31:0] in2,	
	  input [31:0] in3,		
	  output reg [31:0] out
	*/
	
	//ctl_D
	wire J_D;
	wire Jal_D;
	wire Jr_D;
	wire [2:0] NpcSel_D;
	ctl2 ctl_D(
			.Op(opcode_D),
			.Funct(func_D),
			.J(J_D),
			.Jal(Jal_D),
			.Jr(Jr_D),
			.NpcSel(NpcSel_D),
			.ExtOp(ext_op_D)
				);
	
	//npcsel
	wire AddNop;
	NPC npc(PC4_F, NpcSel_D, V1_D, V2_D, J_D, Jr_D, V1_D, imm32_D, imm26_D, nPC_F, AddNop);
	/*
	 input [31:0] pc4,
    input npc_sel,
	 input [31:0] cmp1,
	 input [31:0] cmp2,
    input jump,
	 input jr,
	 input [31:0] gpr,
    input [31:0] imm32,
	 input [25:0] imm26,
    output reg [31:0] npc
	 output reg AddNop
	*/
	
/////////////////////// E ///////////////////////////
	//Regsiter DE
	 wire	[31:0] V1out;
    wire [31:0] V2out;
    wire [31:0] EXT32_E;
    wire [31:0] PC8_E;
    wire [4:0] rs_E;
    wire [4:0] rt_E;
    wire [4:0] rd_E;
    wire [31:0] IR_E;
	DE de(clk, reset, FlushE || AddNop, V1_D, V2_D, imm32_D, PC8_D, rs_D, rt_D, rd_D, IR_D, V1out, V2out, EXT32_E, PC8_E, rs_E, rt_E, rd_E, IR_E);
	/*
	input clk,
	 input reset,
	 input clr,
    input [31:0] V1,
    input [31:0] V2,
    input [31:0] EXT32,
    input [31:0] PC4,
    input [4:0] Rs,
    input [4:0] Rt,
    input [4:0] Rd,
    input [31:0] IR,
    output reg [31:0] V1out,
    output reg [31:0] V2out,
    output reg[31:0] EXT32out,
    output reg [31:0] PC4,
    output reg [4:0] Rsout,
    output reg [4:0] Rtout,
    output reg [4:0] Rdout,
    output reg [31:0] IRout
	 */
	 
	 wire [5:0] opcode_E;
    wire [5:0] func_E;
	 wire [4:0] shamt_E;
	decoder decoderE(
						.IR(IR_E), 
						.opcode(opcode_E), 
						.func(func_E),
						.shamt(shamt_E)
						);
	
	//cltE
	wire [3:0] Aluop;
	wire AluSrc;
	wire [1:0] RegDst;
	ctl2 cltE(
				.Op(opcode_E),
				.Funct(func_E),
				.AluOp(Aluop),
				.AluSrc(AluSrc),
				.RegDst(RegDst)
				);
	 
	 //MUX_RsE
	wire [31:0] fowardRs_E1;
	wire [31:0] fowardRs_E2;
	wire [31:0] fowardRs_E3;
	wire [31:0] fowardRs_E4;
	wire [31:0] fowardRs_E5;
	wire [31:0] fowardRs_E6;
	wire [31:0] fowardRs_E7;
	wire [31:0] V1_E;
	mux32in8 mux_Rs_E(ForwardRsE, V1out, fowardRs_E1, fowardRs_E2, fowardRs_E3, fowardRs_E4, fowardRs_E5, fowardRs_E6, fowardRs_E7, V1_E);
	/*
	  input [1:0]ctl,
	  input [31:0] in0,	
	  input [31:0] in1, 	
	  input [31:0] in2,	
	  input [31:0] in3,		
	  output reg [31:0] out
	*/
	
	//MUX_RtE
	wire [31:0] fowardRt_E1;
	wire [31:0] fowardRt_E2;
	wire [31:0] fowardRt_E3;
	wire [31:0] fowardRt_E4;
	wire [31:0] fowardRt_E5;
	wire [31:0] fowardRt_E6;
	wire [31:0] fowardRt_E7;
	wire [31:0] V2_E;
	mux32in8 mux_Rt_E(ForwardRtE, V2out, fowardRt_E1, fowardRt_E2, fowardRt_E3, fowardRt_E4, fowardRt_E5, fowardRt_E6, fowardRt_E7, V2_E);
	
	//MUX_ALU
	wire [31:0] ALUB;
	mux32in2 mux_ALU(AluSrc, V2_E, EXT32_E, ALUB);
	/*
	  input ctl,
	  input [31:0] in0,	
	  input [31:0] in1	
	  output reg [31:0] out
	*/
	
	//MUX_RFAddr
	wire [4:0] RFAddr_E;
	mux5 mux_RDAddr(RegDst, rt_E, rd_E, 5'b11111, RFAddr_E);
	 
	 //alu
	 wire [31:0] AluResult;
	 ALU alu(V1_E, ALUB, shamt_E, Aluop, AluResult);
	 /*
	 input [31:0] a,
    input [31:0] b,
	 input [10:6] shamt,
    input [3:0] aluctr,
    output reg [31:0] result,
	 */

/////////////////////// M ///////////////////////////	 
	 //Regsiter EM
	 wire [31:0] AluO_M;
	 wire [31:0] WriteData_M;
	 wire [4:0] RFAddr_M;
	 wire [31:0] PC8_M;
	 wire [31:0] IR_M;
	 wire [31:0] Ext32_M;
	 EM em(clk, reset, AluResult, V2_E, EXT32_E, PC8_E, RFAddr_E, IR_E, AluO_M, WriteData_M, Ext32_M, PC8_M, RFAddr_M, IR_M);
	 /*
	 input clk,
	 input reset,
    input [31:0] ALUResult,
    input [31:0] MemData,
	 input [31:0] ext,
    input [31:0] PC4,
    input [4:0] RFAddr,
    input [31:0] IR,
    output reg [31:0] ALUResultO,
    output reg [31:0] MemDataO,
	 output reg [31:0] exto,
    output reg [31:0] PC4O,
    output reg [4:0] RFAddrO,
    output reg [31:0] IRO
	 */
	 
	 //ctlEM
	 wire MemWrite;
	 ctl2 ctlEM(
				.Op(IR_M[31:26]),
				.Funct(IR_M[5:0]),
				.MemWrite(MemWrite)
				);
		
	 //MUX_DM
	wire [31:0] forwardDmin1;
	wire [31:0] DM;
	mux32in2 mux_DM(ForwardDM, WriteData_M, forwardDmin1, DM);
	/*
	  input ctl,
	  input [31:0] in0,	
	  input [31:0] in1	
	  output reg [31:0] out
	*/
		
	 //dm
	 wire [31:0] DataOut_M;
	 dm_4kb dm(PC8_M, AluO_M, MemWrite, reset, DM, clk, DataOut_M);
	 /*
	 input [31:0] pc,
    input [31:0] DataAddress,
    input MemWrite,
    input reset,
    input [31:0] DataIn,
	 input clk,
    output [31:0] DataOut
	 */
	 
/////////////////////// W ///////////////////////////	
	//Regsiter MW
	 wire [31:0] ALUResult_W;
    wire [31:0] MemData_W;
    wire [31:0] PC8_W;
    wire [31:0] IR_W;
    wire [4:0] RFAddr_W;
	MW mw(clk, reset, AluO_M, DataOut_M, PC8_M, IR_M, RFAddr_M, ALUResult_W, MemData_W, PC8_W, IR_W, RFAddr_W);
	/*
	 input clk,
	 input reset,
	 input [31:0] ALUResult,
    input [31:0] MemData,
    input [31:0] PC4,
    input [31:0] IR,
    input [4:0] RFAddr,
    output [31:0] ALUResultO,
    output [31:0] MemDataO,
    output [31:0] PC4O,
    output [31:0] IRO,
    output [4:0] RFAddrO
	*/
	
	//ctlW
	wire [1:0] MemSel;
	ctl2 ctlW(
				.Op(IR_W[31:26]),
				.Funct(IR_W[5:0]),
				.MemToReg(MemSel),
				.RegWrite(RegWrite)
				);
	//MUX_RFMemSel
	mux32in4 mux_RegMem_W(MemSel, ALUResult_W, MemData_W, PC8_W, 32'b0, grf_WD);
	/*
	  input [1:0]ctl,
	  input [31:0] in0,	
	  input [31:0] in1, 	
	  input [31:0] in2,	
	  input [31:0] in3,		
	  output reg [31:0] out
	*/
	assign grf_a3 = RFAddr_W;
	assign WPC = PC8_W - 8;
	
/////////////////////// Hazard ///////////////////////////	
	Hzd hazard(IR_D, IR_E, IR_M, IR_W, RFAddr_E, RFAddr_M, RFAddr_W, PCEnD, EnD, FlushD, ForwardRtD, ForwardRsD, FlushE, ForwardRtE, ForwardRsE, ForwardDM);
/*
	 input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
    input [31:0] IR_W,
	 input [4:0] WriteAddr_E,
	 input [4:0] WriteAddr_M,
	 input [4:0] WriteAddr_W,
    output PCEnD,
    output EnD,
    output FkushD,
    output [2:0] ForwardRtD,
    output [2:0] ForwardRsD,
    output FlushE,
    output [2:0] ForwardRtE,
    output [2:0] ForwardRsE,
	 output ForwardWD
*/
	//RS_D_MUX forward
	assign fowardRs_D1 = PC8_E;
	assign fowardRs_D2 = AluO_M;
	assign fowardRs_D3 = PC8_M;
	assign fowardRs_D4 = grf_WD;
	
	//RT_D_MUX forward
	assign fowardRt_D1 = PC8_E;
	assign fowardRt_D2 = AluO_M;
	assign fowardRt_D3 = PC8_M;
	assign fowardRt_D4 = grf_WD;
	
	//RS_E_MUX forward
	assign fowardRs_E1 = AluO_M;
	assign fowardRs_E2 = PC8_M;
	assign fowardRs_E3 = grf_WD;
	
	//RT_E_MUX forward
	assign fowardRt_E1 = AluO_M;
	assign fowardRt_E2 = PC8_M;
	assign fowardRt_E3 = grf_WD;
	
	//ForwardDM forward
	assign forwardDmin1 = grf_WD;
endmodule
