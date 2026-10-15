`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/08 16:23:44
// Design Name: 
// Module Name: Top
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

module Top(
    input         clk,     
    input  [31:0] sw,         
    input  [6:1]  swb,        
    output [31:0] led         
);


wire CLK;                 
wire PRE = sw[0];    
wire CLR = sw[1];     
wire D   = sw[3];  
wire Q1, Q2;      


dalay de(
    .clk  (clk),             
    .in   (swb[1]),          
    .out  (CLK)           
);


zk zk_utt(
    .PRE  (PRE),     
    .CLR  (CLR),      
    .CLK  (CLK),          
    .D    (D),        
    .Q1   (Q1),         
    .Q2   (Q2)           
);


assign led[31] = Q1;
assign led[30] = Q2;

endmodule
