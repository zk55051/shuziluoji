`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/03 10:45:53
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
    sw,led,led1
    );
    input [7:0] sw;
    output [31:27] led;
    output [3:0] led1;
    
    wire c0,c1,c2,c3,c4;
    
    assign c0=1'b0;
    
    add add_link(.a(sw[1]),.b(sw[0]),.cin(c0),.s(led1[0]),.cout(c1));
    add add_link1(.a(sw[3]),.b(sw[2]),.cin(c1),.s(led1[1]),.cout(c2));
    add add_link2(.a(sw[5]),.b(sw[4]),.cin(c2),.s(led1[2]),.cout(c3));
    add add_link3(.a(sw[7]),.b(sw[6]),.cin(c3),.s(led1[3]),.cout(c4));
    
    assign led[30]=c1;
    assign led[29]=c2;
    assign led[28]=c3;
    assign led[27]=c4;
    assign led[31] = 1'b0;
endmodule
