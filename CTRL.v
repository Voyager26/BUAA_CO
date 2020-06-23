`timescale 1ns / 1ps
`define op 31:26
`define funct 5:0
`define imm26 25:0
`define imm16 15:0
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define s 10:6
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:46:30 11/20/2019 
// Design Name: 
// Module Name:    CTRL 
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
module ctrl(
	input [31:0] Instr,
	//D control
	output reg [2:0] PcSel,
	output reg [1:0] EXTsel,
	output reg [1:0] RegDst,
	output reg [2:0] BranchSel,
	//E control
	output reg [3:0] ALUsel,
	output reg ALU_A_MUXsel,
	output reg ALU_B_MUXsel,
	output reg [2:0] MDUsel,
	output reg Start,
	output reg MDU_RDsel,
	output reg ALU_MDU_MUXsel,
	//M control
	output reg DM_WE,
	output reg [1:0] StoreType,
	output reg [2:0] LoadType,
	//W control
	output reg [1:0] GRF_WD_MUXsel,
	output reg GRF_WE
    );
	
	wire [5:0] Op = Instr[`op];
	wire [5:0] Funct = Instr[`funct];
	wire [4:0] rt = Instr[`rt];
	
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
	initial begin
		BranchSel = 0;
		MDUsel = 0;
		Start = 0;
		ALU_MDU_MUXsel = 0;
		GRF_WE = 0;
		RegDst = 0;
		ALUsel = 0;
		ALU_A_MUXsel = 0;
		ALU_B_MUXsel = 0;
		DM_WE = 0;
		GRF_WD_MUXsel = 0;
	end
	
	always @(*) begin
	//D control
		PcSel[2] = 0;
		PcSel[1] = j | jal | jr | jalr;
		PcSel[0] = jr | jalr | beq | bne | blez | bgtz | bltz | bgez;
		EXTsel[1] = lui;
		EXTsel[0] = andi | ori | xori;
		RegDst[1] = jal;
		RegDst[0] = addi | addiu | andi | ori | xori | lui | slti | sltiu | lw | lh | lb | lhu | lbu ;
		BranchSel[2] = bltz | bgez;
		BranchSel[1] = blez | bgtz;
		BranchSel[0] = bne | bgtz | bgez;
	//E control
		ALUsel[3] = srav | sra | slt | sltu | slti | sltiu;
		ALUsel[2] = ixor | inor | sllv | srlv | srl | xori;
		ALUsel[1] = iand | ior | sllv | srlv | srl | andi | ori | sltu | sltiu;
		ALUsel[0] = sub | subu | ior | inor | srlv | srl | ori | slt | slti;
		ALU_A_MUXsel = srl | sra;
		ALU_B_MUXsel = addi | addiu | andi | ori | xori | slti | sltiu | sw | sh | sb | lw | lh | lb | lhu | lbu ;
		MDUsel[2] = divu | mtlo | mthi;
		MDUsel[1] = multu | div;
		MDUsel[0] = mult | div | mthi;
		Start = mult | multu | div | divu | mtlo;
		MDU_RDsel = mfhi;
		ALU_MDU_MUXsel = mflo | mfhi;
	//M control
		DM_WE = sw | sh | sb;
		StoreType[1] = sb;
		StoreType[0] = sh;
		LoadType[2] = lbu;
		LoadType[1] = lhu | lb;
		LoadType[0] = lh | lb;
	//W control
		GRF_WD_MUXsel[1] = lui | jal | jalr;
		GRF_WD_MUXsel[0] = jal | jalr | lw | lh | lb | lhu | lbu ;
		GRF_WE = add | addi | addu | addiu | sub | subu | iand | ior | ixor | inor | sllv | srlv | srav | srl | sra | andi | ori
					| xori | lui | jal | jalr | slt | sltu | slti | sltiu | lw | lh | lb | lhu | lbu | mflo | mfhi;
					
		if (Op == 6'b000000 && Funct == 6'b000000) begin	//sll
			if(Instr == 32'b0) begin
				PcSel = 0;
				MDUsel = 0;
				Start = 0;
				ALU_MDU_MUXsel = 0;
				GRF_WE = 0;
				RegDst = 0;
				ALUsel = 0;
				ALU_A_MUXsel = 0;
				ALU_B_MUXsel = 0;
				DM_WE = 0;
				GRF_WD_MUXsel = 0;
			end
			else begin
				PcSel = 0;
				MDUsel = 0;
				Start = 0;
				ALU_MDU_MUXsel = 0;
				RegDst = 0;
				ALUsel = 6;
				ALU_A_MUXsel = 1;
				ALU_B_MUXsel = 0;
				DM_WE = 0;
				GRF_WD_MUXsel = 0;
				GRF_WE = 1;
			end
		end
	end
endmodule

