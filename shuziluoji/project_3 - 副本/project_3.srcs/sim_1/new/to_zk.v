`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/10 20:35:59
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

   reg A,B,C,D,E;
   wire Y1;
   initial {A,B,C,D,E}=5'b0;
   always #100 {A,B,C,D,E}={A,B,C,D,E}+5'b1;
   zk testzk(.A(A),.B(B),.C(C),.D(D),.E(E),.Y(Y1));
   

endmodule
