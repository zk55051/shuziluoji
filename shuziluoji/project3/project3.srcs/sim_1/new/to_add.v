`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/17 20:06:00
// Design Name: 
// Module Name: to_add
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


module to_add();

reg a,b,cin;
wire s1,cout1;

initial {a,b,cin}=3'b0;
always #100 {a,b,cin}={a,b,cin}+3'b1;
add add_utt(.a(a),.b(b),.cin(cin),.s(s1),.cout(cout1));
endmodule
