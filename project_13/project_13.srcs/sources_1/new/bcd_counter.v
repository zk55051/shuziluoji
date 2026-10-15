`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: bcd_counter
// Project Name: project_13
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 4 位十进制 BCD 计数器，0000 -> 9999 -> 0000 循环
//              en 为单周期自增脉冲，rst_n 低有效清零
//
//////////////////////////////////////////////////////////////////////////////////


module bcd_counter(
    clk,
    rst_n,
    en,
    data
    );

    input             clk;
    input             rst_n;           // 低有效清零
    input             en;              // 自增使能（单周期脉冲）
    output reg [15:0] data;            // {千,百,十,个} BCD

    reg [3:0] q0, q1, q2, q3;          // 个、十、百、千

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            {q3, q2, q1, q0} <= 16'd0;
        end
        else if (en) begin
            if (q0 != 4'd9) begin
                q0 <= q0 + 1'b1;                       // 个位 +1
            end
            else begin
                q0 <= 4'd0;                            // 个位进位
                if (q1 != 4'd9) begin
                    q1 <= q1 + 1'b1;                   // 十位 +1
                end
                else begin
                    q1 <= 4'd0;                        // 十位进位
                    if (q2 != 4'd9) begin
                        q2 <= q2 + 1'b1;               // 百位 +1
                    end
                    else begin
                        q2 <= 4'd0;                    // 百位进位
                        if (q3 != 4'd9)
                            q3 <= q3 + 1'b1;           // 千位 +1
                        else
                            q3 <= 4'd0;                // 9999 -> 0000
                    end
                end
            end
        end
    end

    always @(*) begin
        data = {q3, q2, q1, q0};
    end

endmodule
