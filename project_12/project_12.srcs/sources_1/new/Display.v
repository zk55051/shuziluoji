`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: Display
// Project Name: project_12
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 数码管动态扫描显示模块（共阳极，段选低有效）
//              轮流点亮 DIGITS 个数码管，配合 scan_tick（1kHz）刷新，稳定显示一个多位数
//              位选 which 从 0 开始，0 对应最高位数码管
//
//////////////////////////////////////////////////////////////////////////////////


module Display #(
    parameter DIGITS = 4               // 数码管位数
    )(
    clk,
    rst_n,
    scan_tick,
    data,
    which,
    seg
    );

    input                 clk;
    input                 rst_n;
    input                 scan_tick;             // 位切换脉冲（1kHz -> 刷新率 250Hz）
    input  [4*DIGITS-1:0] data;                  // 待显示数据（每 4 位一个 BCD）
    output reg [2:0]      which;                 // 位选
    output reg [7:0]      seg;                   // 段选 {A,B,C,D,E,F,G,DP}，低有效

    reg [2:0] sel;
    reg [3:0] digit;

    // 位扫描计数
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            sel <= 3'd0;
        else if (scan_tick)
            sel <= (sel >= DIGITS - 1) ? 3'd0 : sel + 1'b1;
    end

    // 取当前位对应的 BCD 数字（sel=0 对应最高位）
    always @(*) begin
        which = sel;
        digit = data[4*(DIGITS-1-sel) +: 4];
    end

    // 共阳极字形编码（0 亮，1 灭）
    always @(*) begin
        case (digit)
            4'h0: seg = 8'b0000_0011;
            4'h1: seg = 8'b1001_1111;
            4'h2: seg = 8'b0010_0101;
            4'h3: seg = 8'b0000_1101;
            4'h4: seg = 8'b1001_1001;
            4'h5: seg = 8'b0100_1001;
            4'h6: seg = 8'b0100_0001;
            4'h7: seg = 8'b0001_1111;
            4'h8: seg = 8'b0000_0001;
            4'h9: seg = 8'b0000_1001;
            4'ha: seg = 8'b0001_0001;
            4'hb: seg = 8'b1100_0001;
            4'hc: seg = 8'b0110_0011;
            4'hd: seg = 8'b1000_0101;
            4'he: seg = 8'b0110_0001;
            4'hf: seg = 8'b0111_0001;
            default: seg = 8'b1111_1111;         // 全灭
        endcase
    end

endmodule
