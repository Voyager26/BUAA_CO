`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:25:25 11/19/2019
// Design Name:   mips
// Module Name:   C:/ise programmar/cpu_v1.0/mips_tb.v
// Project Name:  cpu_v1.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mips_tb;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk(clk), 
		.reset(reset)
	);

	always #0.5 clk = ~clk;
	
	initial begin
		clk = 0;
		reset = 0;
	end
	
	always@(*) begin
		
	end
	
      
endmodule

