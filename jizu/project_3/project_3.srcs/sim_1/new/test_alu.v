`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/08 11:08:44
// Design Name: 
// Module Name: test_alu
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


module test_alu();

reg [7:0] test_a;
reg [7:0] test_b;
reg [2:0] test_function_sel;
wire [7:0] test_result;
wire test_zero_flag;
wire test_carry_flag;

zk uut (
    .a(test_a),
    .b(test_b),
    .function_sel(test_function_sel),
    .result(test_result),
    .zero_flag(test_zero_flag),
    .carry_flag(test_carry_flag)
);

initial begin
    $display("=== ALU Testbench Started ===");
    
    test_a = 8'b00000000;
    test_b = 8'b00000000;
    test_function_sel = 3'b000;
    #50;
    
    test_a = 8'd100;
    test_b = 8'd50;
    test_function_sel = 3'b000;
    #50;
    $display("ADD: %d + %d = %d, carry=%b, zero=%b", 100, 50, test_result, test_carry_flag, test_zero_flag);
    
    test_a = 8'd200;
    test_b = 8'd100;
    test_function_sel = 3'b001;
    #50;
    $display("SUB: %d - %d = %d, carry=%b, zero=%b", 200, 100, test_result, test_carry_flag, test_zero_flag);
    
    test_a = 8'b11001100;
    test_b = 8'b10101010;
    test_function_sel = 3'b010;
    #50;
    $display("AND: %b & %b = %b", test_a, test_b, test_result);
    
    test_a = 8'b11001100;
    test_b = 8'b10101010;
    test_function_sel = 3'b011;
    #50;
    $display("OR:  %b | %b = %b", test_a, test_b, test_result);
    
    test_a = 8'b11001100;
    test_b = 8'b10101010;
    test_function_sel = 3'b100;
    #50;
    $display("XOR: %b ^ %b = %b", test_a, test_b, test_result);
    
    test_a = 8'b11001100;
    test_function_sel = 3'b101;
    #50;
    $display("NOT: ~%b = %b", test_a, test_result);
    
    test_a = 8'b10101010;
    test_function_sel = 3'b110;
    #50;
    $display("SHL: %b << 1 = %b, carry=%b", 8'b10101010, test_result, test_carry_flag);
    
    test_a = 8'b10101010;
    test_function_sel = 3'b111;
    #50;
    $display("SHR: %b >> 1 = %b", 8'b10101010, test_result);
    
    test_a = 8'd50;
    test_b = 8'd50;
    test_function_sel = 3'b001;
    #50;
    $display("SUB: %d - %d = %d, carry=%b, zero=%b", 50, 50, test_result, test_carry_flag, test_zero_flag);
    
    #100;
    $display("=== ALU Testbench Completed ===");
    $stop;
end

endmodule

