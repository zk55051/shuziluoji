`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: alu
// Project Name: project_12
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 32 位多功能 ALU，4 根控制线 ALU_op[3:0] 选择 16 种功能
//              0000 逻辑与   0001 逻辑或   0010 逻辑异或  0011 逻辑或非
//              0100 补码加   0101 补码减   0110 有符号比较(A<B 输出 1)
//              0111 B 逻辑左移 A 指定的位数    1000~1111 扩展保留(输出 0)
//              ZF 零标志；OF 溢出标志（仅加减有效）
//
//////////////////////////////////////////////////////////////////////////////////


module alu(
    A,
    B,
    ALU_op,
    F,
    ZF,
    OF
    );

    input  wire [31:0] A;
    input  wire [31:0] B;
    input  wire [3:0]  ALU_op;
    output reg  [31:0] F;
    output reg         ZF;
    output reg         OF;

    // 运算功能
    always @(*) begin
        case (ALU_op)
            4'b0000: F = A & B;                                        // 逻辑与
            4'b0001: F = A | B;                                        // 逻辑或
            4'b0010: F = A ^ B;                                        // 逻辑异或
            4'b0011: F = ~(A | B);                                     // 逻辑或非
            4'b0100: F = A + B;                                        // 补码加
            4'b0101: F = A - B;                                        // 补码减
            4'b0110: F = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;    // 有符号比较
            4'b0111: F = B << A[4:0];                                  // 逻辑左移
            default: F = 32'd0;                                        // 1000~1111 保留
        endcase
    end

    // 标志位
    always @(*) begin
        ZF = (F == 32'd0);                                             // 结果为零
        case (ALU_op)
            4'b0100: OF = (~(A[31] ^ B[31])) & (F[31] ^ A[31]);        // 加法溢出
            4'b0101: OF = ( A[31] ^ B[31] ) & (F[31] ^ A[31]);         // 减法溢出
            default: OF = 1'b0;
        endcase
    end

endmodule
