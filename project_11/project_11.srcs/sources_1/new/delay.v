`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: delay
// Project Name: project_11
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 按键消抖：输入稳定 DIV 个时钟后，输出才跟随输入
//
//////////////////////////////////////////////////////////////////////////////////


module delay #(
    parameter DIV = 1_000_000          // 消抖时间对应的时钟数（100MHz 下 1M=10ms）
    )(
    clk,
    in,
    out
    );

    input      clk;
    input      in;
    output reg out;

    reg [31:0] cnt;
    reg        in_d;

    initial begin
        cnt  = 32'd0;
        in_d = 1'b0;
        out  = 1'b0;
    end

    always @(posedge clk) begin
        in_d <= in;
        if (in != in_d) begin
            cnt <= 32'd0;              // 输入变化，重新计时
        end
        else if (cnt < DIV) begin
            cnt <= cnt + 1'b1;
        end
        else begin
            out <= in;                 // 稳定后跟随输入
        end
    end

endmodule
