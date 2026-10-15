`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/17 20:50:48
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
sw,led
    );
    input [31:0] sw;
    output [31:0] led;
    
    add add_and(.a(sw[0]),.b(sw[1]),.cin(sw[2]),.s(led[30]),.cout(led[31]));
endmodule
