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
    output reg [5:0] opcode,
    output reg [4:0] rs,
    output reg [4:0] rt,
    output reg [4:0] rd,
    output reg [4:0] shamt,
    output reg [5:0] func,
    output reg [15:0] imm16,
    output reg [25:0] imm26,
	 output reg [31:0] op
    );
	 reg [31:0] im[1023:0];	//im 32 * 1024bit, 
	 wire [9:0] Addr;			//addr in rom
	 assign Addr = Pc[11:2];	//Pc / 4 (true addr)
	initial begin
		$readmemh("code.txt", im);	//code to imm
	end
	
	always@(*) begin
		opcode = im[Addr][31:26];
		rs = im[Addr][25:21];
		rt = im[Addr][20:16];
		rd = im[Addr][15:11];
		shamt = im[Addr][10:6];
		func = im[Addr][5:0];
		imm26 = im[Addr][25:0];
		imm16 = im[Addr][15:0];
		op = im[Addr][31:0];
	end
endmodule
