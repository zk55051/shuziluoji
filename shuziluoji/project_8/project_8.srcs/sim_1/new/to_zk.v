`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/15 14:40:51
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
reg J,K, CLK;
wire Q1,Q2;

initial begin
    CLK=1'b0;
    {J,K}=2'b0;
end

always #50
CLK = ~CLK;

always #100 begin
{J,K} = {J,K} + 1'b1;
end

zk utt(.CLK(CLK),
    .J(J),
    .K(K),
    .Q1(Q1),
    .Q2(Q2));

endmodule
