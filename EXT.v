`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:31:46 11/18/2019 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] imm16,
    input [3:0] ext_op,
    output reg [31:0] imm32
    );
	
	always@(*) begin
		case(ext_op)
			4'b0000: imm32 = 32'b0;
			4'b0001: imm32 = {{16{1'b0}},imm16}; 
			4'b0010: imm32 = {{16{imm16[15]}}, imm16};
			4'b0011: imm32 = {imm16, {16{1'b0}}};
			4'b0100: imm32 = {{14{imm16[15]}}, imm16, {2'b00}};
		endcase
	end

endmodule
