`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:04:49 11/20/2019 
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
module ext(
	input [15:0] In,
	input [1:0] Op,
	output reg [31:0] Out
    );
	
	always @(*) begin
		case (Op)
			0: Out = {{16{In[15]}}, In[15:0]};
			1: Out = {{16{1'b0}}, In[15:0]};
			2: Out = {In, {16{1'b0}}};
		endcase	
	end
	
endmodule