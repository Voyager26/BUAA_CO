`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:32 11/17/2019 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] aluctr,
    output reg [31:0] result,
	 output reg equal
    );
always@(*)			
		begin
			case(aluctr)				
				4'b0000: result <= a + b;//或
				4'b0001: result <= a - b;//加
				4'b0010: 
					result <= a | b;//减
				4'b0011: begin
					result <= 32'h0000_0000;
					equal <= ($signed(a) == $signed(b)) ? 1'b1 : 1'b0;//若A==B，则result=1
				end
				4'b0100: begin
					result <= 32'h0000_0000;
					equal <= ($signed(a) == $signed(b)) ? 1'b0 : 1'b1;//若A!=B，则result=1
				end
				default:result<=32'h0000_0000;
			endcase
		end
endmodule
