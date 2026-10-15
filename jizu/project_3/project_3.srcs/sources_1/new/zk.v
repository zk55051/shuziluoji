`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/08 10:58:31
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
    input wire [7:0] a,
    input wire [7:0] b,
    input wire [2:0] function_sel,
    output reg [7:0] result,
    output reg zero_flag,
    output reg carry_flag
    );
    
    wire [8:0] add_result;
    wire [8:0] sub_result;
    
    assign add_result = {1'b0, a} + {1'b0, b};
    assign sub_result = {1'b0, a} - {1'b0, b};
    
    always @(*) begin
        carry_flag = 1'b0;
        case (function_sel)
            3'b000: begin
                result = add_result[7:0];
                carry_flag = add_result[8];
            end
            3'b001: begin
                result = sub_result[7:0];
                carry_flag = sub_result[8];
            end
            3'b010: begin
                result = a & b;
            end
            3'b011: begin
                result = a | b;
            end
            3'b100: begin
                result = a ^ b;
            end
            3'b101: begin
                result = ~a;
            end
            3'b110: begin
                result = a << 1;
                carry_flag = a[7];
            end
            3'b111: begin
                result = a >> 1;
            end
            default: begin
                result = 8'b0;
                carry_flag = 1'b0;
            end
        endcase
    end
    
    always @(*) begin
        if (result == 8'b0)
            zero_flag = 1'b1;
        else
            zero_flag = 1'b0;
    end
     
endmodule
