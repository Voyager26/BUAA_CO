`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:44:17 11/18/2019 
// Design Name: 
// Module Name:    mux 
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

//8chose 32bit
module mux32in8(
						input [2:0]ctl,
						input [31:0] in0,	
						input [31:0] in1, 	
						input [31:0] in2,	
						input [31:0] in3,
						input [31:0] in4,	
						input [31:0] in5,
						input [31:0] in6,	
						input [31:0] in7,
						output reg [31:0] out
					);
   always @(*)
		begin
			case(ctl)
			3'b000:	out = in0;
			3'b001:	out = in1;
			3'b010:	out = in2;
			3'b011:	out = in3;
			3'b100:	out = in4;
			3'b101:	out = in5;
			3'b110:	out = in6;
			3'b111:	out = in7;
			endcase
		end
endmodule


//4chose 32bit
module mux32in4(
						input [1:0]ctl,
						input [31:0] in0,	
						input [31:0] in1, 	
						input [31:0] in2,	
						input [31:0] in3,		
						output reg [31:0] out
					);
   always @(*)
		begin
			case(ctl)
			2'b00:	out = in0;
			2'b01:	out = in1;
			2'b10:	out = in2;
			2'b11:	out = in3;
			endcase
		end
endmodule

module mux32in2(
						input ctl,
						input [31:0] in0,	
						input [31:0] in1, 	
						output reg [31:0] out
					);
   always @(*)
		begin
			case(ctl)
			0:	out = in0;
			1:	out = in1;
			endcase
		end
endmodule


//3ѡ1 5bit
module mux5	(
						input [1:0] ctl,
					
						input [4:0] in0,
						input [4:0] in1,
						input [4:0] in2,
						
						output reg [4:0] out
					);
	 always @(*)
		begin
			case(ctl)
			2'b00:	out = in0;
			2'b01:	out = in1;
			2'b10:	out = in2;
			endcase
		end
endmodule
