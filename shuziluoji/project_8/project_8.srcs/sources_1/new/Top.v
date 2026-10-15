`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/15 14:49:55
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
    input [2:0]sw;
    input [6:1]swb;
    output [31:30]led;
    
    wire temp1,temp2,temp3;
    
    delay de(clk, swb[1], temp1);
    delay de1(clk, sw[1],temp2);
    delay de2(clk, sw[0],temp3);
    
    zk zk_utt(.CLK(temp1),
    .J(temp2),
    .K(temp3),
    .Q1(led[31]),
    .Q2(led[30]));
    
endmodule
