`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/10 20:56:41
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
    
    zk zk_utt(.A(sw[31]),.B(sw[30]),.C(sw[29]),.D(sw[28]),.E(sw[27]),.Y(led[31]));
    
endmodule
