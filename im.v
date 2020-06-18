`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:03:20 11/18/2019 
// Design Name: 
// Module Name:    im_4kb 
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
module im_4kb(
    input [31:0] Pc,
    output reg [31:0] IR
    );
	 reg [31:0] im[1023:0];	//im 32 * 1024bit, 
	 wire [9:0] Addr;			//addr in rom
	 assign Addr = Pc[11:2];	//Pc / 4 (true addr)
	initial begin
		$readmemh("code.txt", im);	//code to imm
	end
	
	always@(*) begin
		IR = im[Addr];
	end
endmodule
