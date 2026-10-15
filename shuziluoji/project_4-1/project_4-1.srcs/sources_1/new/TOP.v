`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/24 21:37:59
// Design Name: 
// Module Name: TOP
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
    input wire [31:0]sw;
    output wire [31:0]led;
    
    zk zk_utt(.A(sw[1:0]),.B(sw[3:2]),.C(sw[5:4]),.D(sw[7:6]),.S(sw[9:8]),.EN(sw[16]),.Y(led[31:30]));
endmodule
