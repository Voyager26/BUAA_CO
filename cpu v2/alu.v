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
module ALU(
    input [31:0] a,
    input [31:0] b,
	 input [10:6] shamt,
    input [3:0] aluctr,
    output reg [31:0] result
    );
	 integer temp;
	 integer i;
	 wire [31:0] clz;
	 integer s;
always@(*)	
		begin
			case(aluctr)				
				4'b0000: result <= a + b;//¼Ó
				4'b0001: result <= a - b;//¼õ
				4'b0010: result <= a | b;//»ò
				4'b0011: result <= clz;
				4'b0100: begin
				   s = shamt;
					case(s)
						1:result <= {b[0], b[31:1]};
						2:result <= {b[1:0], b[31:2]};
						3:result <= {b[2:0], b[31:3]};
						4:result <= {b[3:0], b[31:4]};
						5:result <= {b[4:0], b[31:5]};
						6:result <= {b[5:0], b[31:6]};
						7:result <= {b[6:0], b[31:7]};
						8:result <= {b[7:0], b[31:8]};
						9:result <= {b[8:0], b[31:9]};
						10:result <= {b[9:0], b[31:10]};
						11:result <= {b[10:0], b[31:11]};
						12:result <= {b[11:0], b[31:12]};
						13:result <= {b[12:0], b[31:13]};
						14:result <= {b[13:0], b[31:14]};
						15:result <= {b[14:0], b[31:15]};
						16:result <= {b[15:0], b[31:16]};
						17:result <= {b[16:0], b[31:17]};
						18:result <= {b[17:0], b[31:18]};
						19:result <= {b[18:0], b[31:19]};
						20:result <= {b[19:0], b[31:20]};
						21:result <= {b[20:0], b[31:21]};
						22:result <= {b[21:0], b[31:22]};
						23:result <= {b[22:0], b[31:23]};
						24:result <= {b[23:0], b[31:24]};
						25:result <= {b[24:0], b[31:25]};
						26:result <= {b[25:0], b[31:26]};
						27:result <= {b[26:0], b[31:27]};
						28:result <= {b[27:0], b[31:28]};
						29:result <= {b[28:0], b[31:29]};
						30:result <= {b[29:0], b[31:30]};
						31:result <= {b[30:0], b[31]};
						default: result <= b;
						endcase
				end
				default:result<=32'h0000_0000;
			endcase
		end
     assign clz = a[31] == 1 ? 0 :
			  a[30] == 1 ? 1 :
			  a[29] == 1 ? 2 :
			  a[28] == 1 ? 3 :
			  a[27] == 1 ? 4 :
			  a[26] == 1 ? 5 :
			  a[25] == 1 ? 6 :
			  a[24] == 1 ? 7 :
			  a[23] == 1 ? 8 :
			  a[22] == 1 ? 9 :
			  a[21] == 1 ? 10:
			  a[20] == 1 ? 11 :
			  a[19] == 1 ? 12 :
			  a[18] == 1 ? 13 :
			  a[17] == 1 ? 14 :
			  a[16] == 1 ? 15 :
			  a[15] == 1 ? 16 :
			  a[14] == 1 ? 17 :
			  a[13] == 1 ? 18 :
			  a[12] == 1 ? 19 :
			  a[11] == 1 ? 20:
			  a[20] == 1 ? 21 :
			  a[9] == 1 ? 22 :
			  a[8] == 1 ? 23 :
			  a[7] == 1 ? 24 :
			  a[6] == 1 ? 25 :
			  a[5] == 1 ? 26 :
			  a[4] == 1 ? 27 :
			  a[3] == 1 ? 28 :
			  a[2] == 1 ? 29 :
			  a[1] == 1 ? 30 :
			  a[0] == 1 ? 31 :
			  32;
endmodule
