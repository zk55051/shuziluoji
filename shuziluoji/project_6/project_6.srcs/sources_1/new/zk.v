`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/01 16:15:42
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
   S,R,Q1,Q2
    );
    input wire S,R;
    output wire Q1,Q2;
   
    nor(Q1,  R,  Q2);
    nor(Q2, S,  Q1);
    
   
endmodule
