`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/02 21:49:37
// Design Name: 
// Module Name: project_2
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


module project_2(
    sw,led
    );
    
    input wire [31:0]sw; //????(????)
    output wire [31:0]led; //????????
    
    assign led=sw;
    
endmodule
