`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/01 16:30:51
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


reg S,R;
wire Q1,Q2;

initial begin
    
    
    {S,R}=2'b00;
    
    #100
    {S,R}=2'b10;
    
    #100
    {S,R}=2'b00;
    
    end
    /*always  #100 
    {S,R}={S,R}+1'b1;*/
    
 zk utt(.S(S),.R(R),.Q1(Q1),.Q2(Q2));

endmodule
