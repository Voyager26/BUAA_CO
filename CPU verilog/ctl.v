`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:51:21 11/18/2019 
// Design Name: 
// Module Name:    ctl 
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
module ctl(
    input [5:0] opcode,
    input [5:0] func,
    output reg [1:0] Reg_Dst,
    output reg Reg_Write,
    output reg Alu_Src,
    output reg MemToReg,
    output reg Mem_Write,
    output reg NPc_Sel,
    output reg [3:0] Ext_Op,
    output reg [3:0] Alu_Op,
    output reg J,
	 output reg jal,
	 output reg jr,
    output reg tmp
    );


	always@(*) begin
		if(opcode == 6'b000000) begin	//R
			case(func)
			6'b100001:						//addu
			begin
				Reg_Dst = 2'b01;
				Reg_Write = 1;
				Mem_Write = 0;
				MemToReg = 0;
				Alu_Src = 0;
				Alu_Op = 4'b0000;
				Ext_Op = 4'b0000;
				NPc_Sel = 0;
				J = 0;
				jal = 0;
				jr = 0;
				tmp = 0;
			end
			6'b100011:						//subu
			begin
				Reg_Dst = 2'b01;
				Reg_Write = 1;
				Mem_Write = 0;
				MemToReg = 0;
				Alu_Src = 0;
				Alu_Op = 4'b0001;
				Ext_Op = 4'b0000;
				NPc_Sel = 0;
				J = 0;
				jal = 0;
				jr = 0;
				tmp = 0;
			end
			6'b001000:					//jr
				begin
					Reg_Dst = 2'b00;
					Reg_Write = 0;
					Mem_Write = 0;
					MemToReg = 0;
					Alu_Src = 0;
					Alu_Op = 4'b0000;
					Ext_Op = 4'b0000;
					NPc_Sel = 0;
					J = 0;
					jal = 0;
					jr = 1;
					tmp = 0;
				end
			default:						//nop
				begin
					Reg_Dst = 2'b00;
					Reg_Write = 0;
					Mem_Write = 0;
					MemToReg = 0;
					Alu_Src = 0;
					Alu_Op = 4'b0000;
					Ext_Op = 4'b0000;
					NPc_Sel = 0;
					J = 0;
					jal = 0;
					jr = 0;
					tmp = 0;
				end
			endcase
		end
		else begin
			case(opcode)
				6'b100011:					//lw
				begin
					Reg_Dst = 2'b00;
					Reg_Write = 1;
					Mem_Write = 0;
					MemToReg = 1;
					Alu_Src = 1;
					Alu_Op = 4'b0000;
					Ext_Op = 4'b0001;
					NPc_Sel = 0;
					J = 0;
					jal = 0;
					jr = 0;
					tmp = 0;
				end
				
				6'b101011:					//sw
				begin
					Reg_Dst = 2'b00;
					Reg_Write = 0;
					Mem_Write = 1;
					MemToReg = 0;
					Alu_Src = 1;
					Alu_Op = 4'b0000;
					Ext_Op = 4'b0001;
					NPc_Sel = 0;
					J = 0;
					jal = 0;
					jr = 0;
					tmp = 0;
				end
				
				6'b001101:					//ori
				begin
					Reg_Dst = 2'b00;
					Reg_Write = 1;
					Mem_Write = 0;
					MemToReg = 0;
					Alu_Src = 1;
					Alu_Op = 4'b0010;
					Ext_Op = 4'b0000;
					NPc_Sel = 0;
					J = 0;
					jal = 0;
					jr = 0;
					tmp = 0;
				end
				
				6'b001111:					//lui
				begin
					Reg_Dst = 2'b00;
					Reg_Write = 1;
					Mem_Write = 0;
					MemToReg = 0;
					Alu_Src = 1;
					Alu_Op = 4'b0000;
					Ext_Op = 4'b0010;
					NPc_Sel = 0;
					J = 0;
					jal = 0;
					jr = 0;
					tmp = 0;
				end
				
				6'b000100:					//beq
				begin
					Reg_Dst = 2'b00;
					Reg_Write = 0;
					Mem_Write = 0;
					MemToReg = 0;
					Alu_Src = 0;
					Alu_Op = 4'b0011;
					Ext_Op = 4'b0011;
					NPc_Sel = 1;
					J = 0;
					jal = 0;
					jr = 0;
					tmp = 0;
				end
				
				6'b000010:					//j
				begin
					Reg_Dst = 2'b00;
					Reg_Write = 0;
					Mem_Write = 0;
					MemToReg = 0;
					Alu_Src = 0;
					Alu_Op = 4'b0000;
					Ext_Op = 4'b0000;
					NPc_Sel = 0;
					J = 1;
					jal = 0;
					jr = 0;
					tmp = 0;
				end
				
				6'b000011:					//jal
				begin
					Reg_Dst = 2'b10;
					Reg_Write = 1;
					Mem_Write = 0;
					MemToReg = 0;
					Alu_Src = 0;
					Alu_Op = 4'b0000;
					Ext_Op = 4'b0000;
					NPc_Sel = 0;
					J = 1;
					jal = 1;
					jr = 0;
					tmp = 0;
				end
				
				default:						//nop
				begin
					Reg_Dst = 2'b00;
					Reg_Write = 0;
					Mem_Write = 0;
					MemToReg = 0;
					Alu_Src = 0;
					Alu_Op = 4'b0000;
					Ext_Op = 4'b0000;
					NPc_Sel = 0;
					J = 0;
					jal = 0;
					jr = 0;
					tmp = 0;
				end
			endcase
		end
	end

endmodule
