`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/17 20:02:38
// Design Name: 
// Module Name: add
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


module add(
   a,b,cin,s,cout
    );
    input wire a,b,cin;
    output wire s,cout;
    
    assign s=a^b^cin;
    assign cout=(a&b)|(a&cin)|(b&cin);
endmodule
