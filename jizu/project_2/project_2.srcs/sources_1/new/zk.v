`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/10 11:35:42
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
    input a,
    input b,
    input cin,
    output s,
    output p,  // ??¦Ë????
    output g   // ??¦Ë????
    );
    assign p = a ^ b;
    assign g = a & b;
    assign s = p ^ cin;
    
endmodule
