`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: bcd_cnt
// Project Name: project_11
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 可配置模值的两位十进制 BCD 计数器
//              计数范围：INIT ~ MAX，到达 MAX 后回绕到 INIT，并输出一位进位 carry
//              例：秒/分 MAX=59, INIT=0；时 MAX=23, INIT=0；
//                  日 MAX=31, INIT=1；月 MAX=12, INIT=1；年 MAX=99, INIT=0
//
//////////////////////////////////////////////////////////////////////////////////


module bcd_cnt #(
    parameter MAX  = 59,               // 最大计数值（十进制）
    parameter INIT = 0                 // 复位值 / 回绕值
    )(
    clk,
    rst_n,
    en,
    q,
    carry
    );

    input             clk;
    input             rst_n;           // 低有效复位
    input             en;              // 计数使能
    output reg [7:0]  q;               // {高位BCD, 低位BCD}
    output reg        carry;           // 计数回绕时输出一个周期进位

    localparam HI_MAX = MAX / 10;      // 高位数最大值
    localparam LO_MAX = MAX % 10;      // 低位数最大值

    wire at_last = (q[7:4] == HI_MAX) && (q[3:0] == LO_MAX);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q     <= INIT;
            carry <= 1'b0;
        end
        else if (en) begin
            if (at_last) begin
                q     <= INIT;                     // 回绕
                carry <= 1'b1;
            end
            else begin
                if (q[3:0] == 4'd9) begin
                    q[3:0] <= 4'd0;                // 低位进位
                    q[7:4] <= q[7:4] + 1'b1;
                end
                else begin
                    q[3:0] <= q[3:0] + 1'b1;
                end
                carry <= 1'b0;
            end
        end
        else begin
            carry <= 1'b0;
        end
    end

endmodule
