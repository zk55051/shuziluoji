`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/10 11:05:27
// Design Name: 
// Module Name: TOP
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


module TOP(
    input [7:0] sw,
    output [4:0] led
    );
    
    wire [3:0] p;
    wire [3:0] g;
    wire [3:0] c_out;
    
    wire s0, s1, s2, s3;
    
    
    zk zk0 (.a(sw[0]), .b(sw[1]), .cin(1'b0),   .s(s0), .p(p[0]), .g(g[0]));
    zk zk1 (.a(sw[2]), .b(sw[3]), .cin(c_out[0]), .s(s1), .p(p[1]), .g(g[1]));
    zk zk2 (.a(sw[4]), .b(sw[5]), .cin(c_out[1]), .s(s2), .p(p[2]), .g(g[2]));
    zk zk3 (.a(sw[6]), .b(sw[7]), .cin(c_out[2]), .s(s3), .p(p[3]), .g(g[3]));
    
    
    add add_inst(
        .p(p),
        .g(g),
        .cin(1'b0),
        .c_out(c_out)
    );
    
    
    assign led[0] = s0;
    assign led[1] = s1;
    assign led[2] = s2;
    assign led[3] = s3;
    assign led[4] = c_out[3];  
endmodule
