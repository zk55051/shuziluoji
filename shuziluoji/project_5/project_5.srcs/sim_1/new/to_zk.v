`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/01 12:36:21
// Design Name: 
// Module Name: to_zk
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


module to_zk();

reg C,B,A,G1,G2A,G2B;
wire Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7;
initial begin
    C=1'b0;
    B=1'b0;
    A=1'b0;
    G1=1'b0;
    G2A=1'b0;
    G2B=1'b0;
    
    #100
    G2A=1'b1;
    #100
    G2A=G2A+1;
    G2B=1'b1;
    
    #100
    G1=1'b1;
    G2A=1'b0;
    G2B=1'b0;
end
always #50
{C,B,A}={C,B,A}+1'b1;
zk utt(.C(C),.B(B),.A(A),.G1(G1),.G2A(G2A),.G2B(G2B),.Y7(Y7),.Y6(Y6),.Y5(Y5),.Y4(Y4),.Y3(Y3),.Y2(Y2),.Y1(Y1),.Y0(Y0));
endmodule
