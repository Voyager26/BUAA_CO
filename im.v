`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:25:21 11/20/2019 
// Design Name: 
// Module Name:    IM 
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
module im(
	input [31:0] A,
	output [31:0] Instr
    );
	
	integer i;
	
	reg [31:0] ROM[4095:0];
	
	initial begin 
		for (i = 0; i < 4096; i = i + 1)
			ROM[i] = 0;
		$readmemh("code.txt", ROM);
	end
	
	wire [31:0] A1 = A - 32'h3000;		//Ƭѡ
	assign Instr = ROM[A1[13:2]];
	
endmodule
