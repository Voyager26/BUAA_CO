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
// Create Date:    20:07:22 11/30/2019 
// Design Name: 
// Module Name:    HzdOp 
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
module HzdOp(
    input [31:0] Instr,
	 output Cal_r,
	 output Cal_i,
	 output Lui,
	 output Load,
	 output Store,
	 output Branch,
	 output Jal,
	 output Jr,
	 output Jalr
    );
	wire [5:0] Op = Instr[`op];
	wire [5:0] Funct = Instr[`funct];
	
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
	
	assign Cal_r = addu || subu || clz || rotr;
	assign Cal_i = ori || lui;
	assign Lui = lui;
	assign Load = lw;
	assign Store = sw;
	assign Branch = beq || bgezal || blez;
	assign Jal = jal || bgezal;
	assign Jr = jr;
	assign Jalr = jalr;
	
endmodule
