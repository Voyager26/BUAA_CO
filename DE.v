`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:10:21 11/25/2019 
// Design Name: 
// Module Name:    DE 
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
module DE(
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
    output reg [31:0] PC4out,
    output reg [4:0] Rsout,
    output reg [4:0] Rtout,
    output reg [4:0] Rdout,
    output reg [31:0] IRout
    );
	initial begin
		V1out = 0;
		V2out = 0;
		EXT32out = 0;
		PC4out = 32'h3004;
    	Rsout = 0;
		Rtout = 0;
		Rdout = 0;
		IRout = 0;
	end
	
	always @(posedge clk) begin
		if (reset || clr) begin
			V1out = 0;
			V2out = 0;
			EXT32out = 0;
			PC4out = 32'h3004;
			Rsout = 0;
			Rtout = 0;
			Rdout = 0;
			IRout = 0;
		end
		else begin
			V1out = V1;
			V2out = V2;
			EXT32out = EXT32;
			PC4out = PC4;
			Rsout = Rs;
			Rtout = Rt;
			Rdout = Rd;
			IRout = IR;
		end
	end

endmodule
