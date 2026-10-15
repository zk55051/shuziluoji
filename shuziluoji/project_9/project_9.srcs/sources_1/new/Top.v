`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/15 17:27:47
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top(
    clk,
    sw,
    swb,
    led
    );
    input clk;
    input [31:0] sw;
    input [6:1]swb;
    output [31:16]led;
    
    wire CLK;
    delay de(.clk(clk),.in(swb[1]),.out(CLK));
    
   zk zk_utt(.MR(sw[15]),.Load(sw[14]),.EN(sw[13]),.CLK(CLK),.D(sw[3:0]),.Q(led[31:28]),.CO(led[16]));
endmodule
