`timescale 1ns / 1ps
`define op 31:26
`define funct 5:0
`define imm26 25:0
`define imm16 15:0
`define rs 25:21
`define rt 20:16
`define rd 15:11
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:07:22 11/30/2019 
// Design Name: 
// Module Name:    HzdOp 
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
module HzdOp(
    input [31:0] Instr,
	 output Cal_r,
	 output Cal_i,
	 output Lui,
	 output Load,
	 output Store,
	 output Branch,
	 output Jal,
	 output Jr,
	 output Jalr,
	 output Shift
    );
	wire [5:0] Op = Instr[`op];
	wire [5:0] Funct = Instr[`funct];
	wire [5:0] rt = Instr[`rt];
	
	wire addu = (Op == 6'b000000 & Funct == 6'b100001);
	wire subu = (Op == 6'b000000 & Funct == 6'b100011);
	wire ori = (Op == 6'b001101);
	wire lui = (Op == 6'b001111);
	wire j = (Op == 6'b000010);
	wire jal = (Op == 6'b000011);
	wire jr = (Op == 6'b000000 & Funct == 6'b001000);
	wire jalr = (Op == 6'b000000 & Funct == 6'b001001);
	wire iand = (Op == 6'b000000 & Funct == 6'b100100);
	wire ior = (Op == 6'b000000 & Funct == 6'b100101);
	wire ixor = (Op == 6'b000000 & Funct == 6'b100110);
	wire inor = (Op == 6'b000000 & Funct == 6'b100111);
	wire add = (Op == 6'b000000 & Funct == 6'b100000);
	wire sub = (Op == 6'b000000 & Funct == 6'b100010);
	wire addi = (Op == 6'b001000);
	wire addiu = (Op == 6'b001001);
	wire andi = (Op == 6'b001100);
	wire xori = (Op == 6'b001110);
	wire beq = (Op == 6'b000100);
	wire bne = (Op == 6'b000101);
	wire blez = (Op == 6'b000110);
	wire bgtz = (Op == 6'b000111);
	wire bltz = (Op == 6'b000001 & rt == 5'b00000);
	wire bgez = (Op == 6'b000001 & rt == 5'b00001);
	wire sllv = (Op == 6'b000000 & Funct == 6'b000100);
	wire srlv = (Op == 6'b000000 & Funct == 6'b000110);
	wire srav = (Op == 6'b000000 & Funct == 6'b000111);
	wire sll = (Op == 6'b000000 & Funct == 6'b000000);
	wire srl = (Op == 6'b000000 & Funct == 6'b000010);
	wire sra = (Op == 6'b000000 & Funct == 6'b000011);
	wire slt = (Op == 6'b000000 & Funct == 6'b101010);
	wire sltu = (Op == 6'b000000 & Funct == 6'b101011);
	wire slti = (Op == 6'b001010);
	wire sltiu = (Op == 6'b001011);
	wire sw = (Op == 6'b101011);
	wire sh = (Op == 6'b101001);
	wire sb = (Op == 6'b101000);
	wire lw = (Op == 6'b100011);
	wire lh = (Op == 6'b100001);
	wire lhu = (Op == 6'b100101);
	wire lb = (Op == 6'b100000);
	wire lbu = (Op == 6'b100100);
	wire mult = (Op == 6'b000000 & Funct == 6'b011000);
	wire multu = (Op == 6'b000000 & Funct == 6'b011001);
	wire div = (Op == 6'b000000 & Funct == 6'b011010);
	wire divu = (Op == 6'b000000 & Funct == 6'b011011);
	wire mtlo = (Op == 6'b000000 & Funct == 6'b010011);
	wire mthi = (Op == 6'b000000 & Funct == 6'b010001);
	wire mflo = (Op == 6'b000000 & Funct == 6'b010010);
	wire mfhi = (Op == 6'b000000 & Funct == 6'b010000);
	
	assign Cal_r = addu | subu | iand | ior | ixor | inor | add | sub | sllv | srlv | srav | slt | sltu | mult | multu | div | divu | mtlo | mthi | mflo | mfhi;
	assign Cal_i = ori | addi | addiu | andi | xori | slti | sltiu;
	assign Lui = lui;
	assign Load = lw | lh | lhu | lb | lbu;
	assign Store = sw | sh | sb;
	assign Branch = beq | bne | blez | bgtz | bltz | bgez;
	assign Jal = jal;
	assign Jr = jr;
	assign Jalr = jalr;
	assign Shift = sll | srl | sra;
	
	
endmodule
