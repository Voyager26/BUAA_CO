`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:07:21 11/25/2019 
// Design Name: 
// Module Name:    MW 
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
module MW(
	 input clk,
	 input reset,
    input [31:0] ALUResult,
    input [31:0] MemData,
    input [31:0] PC4,
    input [31:0] IR,
    input [4:0] RFAddr,
    output reg [31:0] ALUResultO,
    output reg [31:0] MemDataO,
    output reg [31:0] PC4O,
    output reg [31:0] IRO,
    output reg [4:0] RFAddrO
    );
	initial begin
		ALUResultO = 0;
		MemDataO = 0;
		PC4O = 32'h3004;
		IRO = 0;
		RFAddrO = 0;
	end
	always @(posedge clk) begin
		if (reset) begin
			ALUResultO = 0;
			MemDataO = 0;
			PC4O = 32'h3004;
			IRO = 0;
			RFAddrO = 0;
		end
		else begin
			ALUResultO = ALUResult;
			MemDataO = MemData;
			PC4O = PC4;
			IRO = IR;
			RFAddrO = RFAddr;
		end
	end
endmodule
