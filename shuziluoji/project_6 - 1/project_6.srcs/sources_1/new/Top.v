`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/01 17:00:44
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
    sw,
    led
    );
    input wire [16:0]sw;
    output wire [31:30]led;
    assign led[16]=1'b1;
zk zk_utt(
    .S(sw[1]),
    .R(sw[0]),
    .Q1(led[31]),
    .Q2(led[30])
);
endmodule
