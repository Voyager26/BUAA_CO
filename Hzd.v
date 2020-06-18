`timescale 1ns / 1ps
`define op 31:26
`define funct 5:0
`define imm26 25:0
`define imm16 15:0
`define rs 25:21
`define rt 20:16
`define rd 15:11
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:57:26 11/26/2019 
// Design Name: 
// Module Name:    Hzd 
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
module Hzd(
	 input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
    input [31:0] IR_W,
	 input [4:0] WriteAddr_E,
	 input [4:0] WriteAddr_M,
	 input [4:0] WriteAddr_W,
    output PCEnD,
    output EnD,
    output FlushD,
    output [2:0] ForwardRtD,
    output [2:0] ForwardRsD,
    output FlushE,
    output [2:0] ForwardRtE,
    output [2:0] ForwardRsE,
	 output ForwardWD
    );
	wire [4:0] rs_D = IR_D[`rs];
	wire [4:0] rt_D = IR_D[`rt];
	wire [4:0] rs_E = IR_E[`rs];
	wire [4:0] rt_E = IR_E[`rt];
	wire [4:0] rt_M = IR_M[`rt];
	wire [4:0] rd_M = IR_M[`rd];
	wire [4:0] rt_W = IR_W[`rt];
	
	//D classes
	wire Cal_r_D;
	wire Cal_i_D;
	wire Lui_D;
	wire Load_D;
	wire Store_D;
	wire Branch_D;
	wire Jal_D;
	wire Jr_D;
	wire Jalr_D;
	HzdOp hzdOp_D (IR_D, Cal_r_D, Cal_i_D, Lui_D, Load_D, Store_D, Branch_D, Jal_D, Jr_D, Jalr_D);
	
	//E classes
	wire Cal_r_E;
	wire Cal_i_E;
	wire Lui_E;
	wire Load_E;
	wire Store_E;
	wire Branch_E;
	wire Jal_E;
	wire Jr_E;
	wire Jalr_E;
	HzdOp hzdOp_E (IR_E, Cal_r_E, Cal_i_E, Lui_E, Load_E, Store_E, Branch_E, Jal_E, Jr_E, Jalr_E);
	
	//M classes
	wire Cal_r_M;
	wire Cal_i_M;
	wire Lui_M;
	wire Load_M;
	wire Store_M;
	wire Branch_M;
	wire Jal_M;
	wire Jr_M;
	wire Jalr_M;
	HzdOp hzdOp_M (IR_M, Cal_r_M, Cal_i_M, Lui_M, Load_M, Store_M, Branch_M, Jal_M, Jr_M, Jalr_M);
	
	//W classes
	wire Cal_r_W;
	wire Cal_i_W;
	wire Lui_W;
	wire Load_W;
	wire Store_W;
	wire Branch_W;
	wire Jal_W;
	wire Jr_W;
	wire Jalr_W;
	HzdOp hzdOp_W (IR_W, Cal_r_W, Cal_i_W, Lui_W, Load_W, Store_W, Branch_W, Jal_W, Jr_W, Jalr_W);
	
	/////////////////////////// stop /////////////////////////////
	wire [2:0] T_use_rs;
	wire [2:0] T_use_rt;
	wire [2:0] T_new_E;
	wire [2:0] T_new_M;
	assign T_use_rs = Cal_r_D || Cal_i_D || Load_D || Store_D;
	assign T_use_rt = Load_D ? 3'd2 : Cal_r_D ? 3'd1 : 3'd0;
			 
	assign T_new_E = (Cal_r_E || Cal_i_E) ? 3'd1 :
							Load_E ? 3'd2 :
							3'd0;
	assign T_new_M = Load_M ? 3'd1 : 3'd0;
	
	wire stall_rs,stall_rt,stall_rs0_e,stall_rs0_m,stall_rt0_e,stall_rt0_m;
	
	assign stall=stall_rs||stall_rt;
	assign stall_rs = stall_rs0_e || stall_rs0_m;
	assign stall_rt = stall_rt0_e || stall_rt0_m;
						  
	assign stall_rs0_e = (T_use_rs < T_new_E) && (rs_D==WriteAddr_E)&&(rs_D!=0&&WriteAddr_E!=0);
	assign stall_rs0_m = (T_use_rs < T_new_M) && (rs_D==WriteAddr_M)&&(rs_D!=0&&WriteAddr_M!=0);

	assign stall_rt0_e = (T_use_rt < T_new_E) && (rt_D==WriteAddr_E)&&(rt_D!=0&&WriteAddr_E!=0);
	assign stall_rt0_m = (T_use_rt < T_new_M) && (rt_D==WriteAddr_M)&&(rt_D!=0&&WriteAddr_M!=0);

	assign PCEnD = !stall;
   assign EnD = !stall;
   assign FlushD = stall;
	assign FlushE = stall;
	
	/////////////////////////// forward /////////////////////////////
	
	assign Demander_rs_D = Branch_D | Jr_D | Cal_r_D | Cal_i_D | Load_D | Store_D | Jalr_D;	
	assign Demander_rt_D = Branch_D | Cal_r_D | Store_D;
	assign Demander_rs_E = Cal_r_E | Cal_i_E | Load_E | Store_E;
	assign Demander_rt_E = Cal_r_E | Store_E;
	assign Demander_rt_M = Store_M;
	//D
	//0:RD1 1:PC8_E 2:AluO_M 3:PC8_M 4:grf_WD;
	assign ForwardRsD =
		(Demander_rs_D & Jal_E & rs_D != 0 & rs_D == 31) ? 3'd1 :
		(Demander_rs_D & Jalr_E & rs_D != 0 & rs_D == 31) ? 3'd1 :
		(Demander_rs_D & Cal_r_M & rs_D != 0 & rs_D == WriteAddr_M) ? 3'd2 :
		(Demander_rs_D & Cal_i_M & rs_D != 0 & rs_D == WriteAddr_M) ? 3'd2 :
		(Demander_rs_D & Jal_M & rs_D != 0 & rs_D == 31) ? 3'd3 :
		(Demander_rs_D & Cal_r_W & rs_D != 0 & rs_D == WriteAddr_W) ? 3'd4 :
		(Demander_rs_D & Cal_i_W & rs_D != 0 & rs_D == WriteAddr_W) ? 3'd4 :
		(Demander_rs_D & Load_W & rs_D != 0 & rs_D == WriteAddr_W) ? 3'd4 :
		(Demander_rs_D & Jal_W & rs_D != 0 & rs_D == 31) ? 3'd4 :
		3'd0;
	
	assign ForwardRtD = 
		(Demander_rt_D & Jal_E & rt_D != 0 & rt_D == 31) ? 3'd1 :
		(Demander_rt_D & Jalr_E & rt_D != 0 & rt_D == 31) ? 3'd1 :
		(Demander_rt_D & Cal_r_M & rt_D != 0 & rt_D == WriteAddr_M) ? 3'd2 :
		(Demander_rt_D & Cal_i_M & rt_D != 0 & rt_D == WriteAddr_M) ? 3'd2 :
		(Demander_rt_D & Jal_M & rt_D != 0 & rt_D == 31) ? 3'd3 :
		(Demander_rt_D & Cal_r_W & rt_D != 0 & rt_D == WriteAddr_W) ? 3'd4 :
		(Demander_rt_D & Cal_i_W & rt_D != 0 & rt_D == WriteAddr_W) ? 3'd4 :
		(Demander_rt_D & Load_W & rt_D != 0 & rt_D == WriteAddr_W) ? 3'd4 :
		(Demander_rt_D & Jal_W & rt_D != 0 & rt_D == 31) ? 3'd4 :
		3'd0;
	//E
	//0:V1 1:AluO_M 2:PC8_M 3:grf_WD;
	assign ForwardRsE = 
		(Demander_rs_E & Cal_r_M & rs_E != 0 & rs_E == WriteAddr_M) ? 3'd1 :
		(Demander_rs_E & Cal_i_M & rs_E != 0 & rs_E == WriteAddr_M) ? 3'd1 :
		(Demander_rs_E & Jal_M & rs_E != 0 & rs_E == 31) ? 3'd2 :
		(Demander_rs_E & Cal_r_W & rs_E != 0 & rs_E == WriteAddr_W) ? 3'd3 :
		(Demander_rs_E & Cal_i_W & rs_E != 0 & rs_E == WriteAddr_W) ? 3'd3 :
		(Demander_rs_E & Load_W & rs_E != 0 & rs_E == WriteAddr_W) ? 3'd3 :
		(Demander_rs_E & Jal_W & rs_E != 0 & rs_E == 31) ? 3'd3 :
		3'd0;
		
	assign ForwardRtE = 
		(Demander_rt_E & Cal_r_M & rt_E != 0 & rt_E == WriteAddr_M) ? 3'd1 :
		(Demander_rt_E & Cal_i_M & rt_E != 0 & rt_E == WriteAddr_M) ? 3'd1 :
		(Demander_rt_E & Jal_M & rt_E != 0 & rt_E == 31) ? 3'd2 :
		(Demander_rt_E & Cal_r_W & rt_E != 0 & rt_E == WriteAddr_W) ? 3'd3 :
		(Demander_rt_E & Cal_i_W & rt_E != 0 & rt_E == WriteAddr_W) ? 3'd3 :
		(Demander_rt_E & Load_W & rt_E != 0 & rt_E == WriteAddr_W) ? 3'd3 :
		(Demander_rt_E & Jal_W & rt_E != 0 & rt_E == 31) ? 3'd3 :
		3'd0;
		
	//M
	//0:WD 1:grf_WD
	assign ForwardWD = 
		(Demander_rt_M & Cal_r_W & rt_M != 0 & rt_M == WriteAddr_W) ? 1'd1 :
		(Demander_rt_M & Cal_i_W & rt_M != 0 & rt_M == WriteAddr_W) ? 1'd1 :
		(Demander_rt_M & Load_W & rt_M != 0 & rt_M == WriteAddr_W) ? 1'd1 :
		(Demander_rt_M & Jal_W & rt_M != 0 & rt_M == 31) ? 1'd1 :
		1'd0;
endmodule
