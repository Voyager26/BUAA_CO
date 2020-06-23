`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:12:51 11/18/2019 
// Design Name: 
// Module Name:    grf 
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
module GRF(
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
    );
	reg [31:0] register[31:0];		//32 * 32bit register
	integer i;
	initial begin
		for(i = 0; i < 32; i = i + 1) 
			register[i] <= 0;
	end
	wire [4:0] save;
	assign RD1 = register[a1];
	assign RD2 = register[a2];
	always@(posedge clk) begin
		if(reset) begin
			for(i = 1; i < 32; i = i + 1) 
					register[i] <= 0;
		end
		else if(regWrite) begin
			if(a3 == 0)
					register[a3] <= 0;
			else 
					register[a3] <= WriteData;
			$display("%d@%h: $%d <= %h", $time, WPC, a3, WriteData);
		end
	end

endmodule
