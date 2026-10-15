`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/24 20:49:53
// Design Name: 
// Module Name: zk
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


module zk(
  A,B,C,D,EN,S,Y
    );
    input wire [1:0] A,B,C,D,S;
    input wire EN;
    output wire [1:0] Y;
    
    assign Y = EN ? 2'b00:
                (S == 2'b00) ? A:
                (S == 2'b01) ? B:
                (S == 2'b10) ? C:
                D;
endmodule
