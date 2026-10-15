`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/08 10:51:24
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
    sw,led
); 

    input [31:0] sw;
    output [31:0] led;
    
    wire [7:0] operand_a;
    wire [7:0] operand_b;
    wire [2:0] function_sel;
    wire [7:0] alu_result;
    wire zero_flag;
    wire carry_flag;
    
    assign operand_a = sw[7:0];
    assign operand_b = sw[15:8];
    assign function_sel = sw[18:16];
    
    zk alu_inst(
        .a(operand_a),
        .b(operand_b),
        .function_sel(function_sel),
        .result(alu_result),
        .zero_flag(zero_flag),
        .carry_flag(carry_flag)
    );
    
    assign led[7:0] = alu_result;
    assign led[8] = zero_flag;
    assign led[9] = carry_flag;
    assign led[31:10] = 22'b0;
      
endmodule
