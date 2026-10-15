`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/01 13:10:11
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


module TOP(
   sw,led
    );
    input wire [15:0]sw;
    output wire [23:16]led;
    
    zk zk_utt(.C(sw[2]),.B(sw[1]),.A(sw[0]),.G1(sw[15]),.G2A(sw[14]),.G2B(sw[13]),.Y7(led[23]),.Y6(led[22]),.Y5(led[21]),.Y4(led[20]),.Y3(led[19]),.Y2(led[18]),.Y1(led[17]),.Y0(led[16]));
endmodule
