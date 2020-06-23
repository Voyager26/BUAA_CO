`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:44:22 11/25/2019 
// Design Name: 
// Module Name:    EM 
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
module EM(
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
    );
	initial begin
		ALUResultO = 0;
		MemDataO = 0;
		exto = 0;
		PC4O = 32'h3004;
		RFAddrO = 0;
		IRO = 0;
	end

	always @(posedge clk) begin
		if (reset) begin
			ALUResultO = 0;
			MemDataO = 0;
			exto = 0;
			PC4O = 32'h3004;
			RFAddrO = 0;
			IRO = 0;
		end
		else begin
			ALUResultO = ALUResult;
			MemDataO = MemData;
			exto = ext;
			PC4O = PC4;
			RFAddrO = RFAddr;
			IRO = IR;
		end
	end
endmodule
