`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: freq_div
// Project Name: project_11
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 计数型分频器，每 DIV 个时钟输出一个单周期脉冲 tick
//              分频倍数决定计数器位数：例 100MHz->1kHz 分频系数 100k，计数器 17 位
//
//////////////////////////////////////////////////////////////////////////////////


module freq_div #(
    parameter DIV = 100_000            // 分频系数（每 DIV 个时钟输出一个 tick）
    )(
    clk,
    rst_n,
    tick
    );

    input      clk;
    input      rst_n;                  // 低有效复位
    output reg tick;

    reg [31:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt  <= 32'd0;
            tick <= 1'b0;
        end
        else if (cnt == DIV - 1) begin
            cnt  <= 32'd0;
            tick <= 1'b1;              // 每 DIV 个时钟产生一个单周期脉冲
        end
        else begin
            cnt  <= cnt + 1'b1;
            tick <= 1'b0;
        end
    end

endmodule
