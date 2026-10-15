`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/24 21:28:25
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
reg [1:0] A,B,C,D,S;
reg EN;
wire [1:0] Y;

   initial begin
   A=2'b01;
   B=2'b10;
   C=2'b11;
   D=2'b00;
   EN=1;
   S=2'b00;
   
   #10
   EN=0;
   
  
   end
   always #100 S=S+2'b1;
   zk utt(
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .S(S),
    .EN(EN),
    .Y(Y)
   );
endmodule
