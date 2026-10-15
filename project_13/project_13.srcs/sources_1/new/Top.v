`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: Top
// Project Name: project_13
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 附加实验 数码管扫描显示
//              4 位数码管自动递增显示十进制 0000~9999（速率约 5 次/秒）
//              sw[0]  : Start/Stop  自增使能（=1 递增，=0 停止）
//              sw[1]  : CLR         清零信号（=0 则显示 0000）
//              clk    : 系统 100MHz 时钟（10ns），作为延时时基
//
//////////////////////////////////////////////////////////////////////////////////


module Top #(
    parameter DIV_INC  = 20_000_000,   // 自增分频：100MHz / 20M = 5Hz（每秒自增 5 个数值）
    parameter DIV_SCAN = 100_000       // 扫描分频：100MHz / 100k = 1kHz（4 位合计刷新率 250Hz）
    )(
    clk,
    sw,
    led,
    seg,
    which,
    enable
    );

    input              clk;       // 系统时钟 100MHz
    input       [31:0] sw;        // sw[0]: Start/Stop 自增使能; sw[1]: CLR 清零(低有效)
    output      [15:0] led;       // 显示当前计数值（调试用）
    output      [7:0]  seg;       // 段选 A~G、DP
    output      [2:0]  which;     // 位选（经板载 3:8 译码器选择 8 个数码管）
    output             enable;    // 3:8 译码器使能

    wire clr_;                    // 低有效清零
    wire start;                   // 自增使能
    wire inc_tick;                // 自增脉冲（5Hz）
    wire scan_tick;               // 扫描脉冲（1kHz）
    wire [15:0] data;             // 4 位 BCD 数值

    assign clr_  = sw[1];         // sw[1]=0 时清零，数码管显示 0000
    assign start = sw[0];         // sw[0]=1 自动递增，=0 停止自动递增

    // 自增速率分频
    freq_div #(.DIV(DIV_INC)) u_inc(
        .clk   (clk),
        .rst_n (clr_),
        .tick  (inc_tick)
    );

    // 动态扫描分频
    freq_div #(.DIV(DIV_SCAN)) u_scan(
        .clk   (clk),
        .rst_n (1'b1),
        .tick  (scan_tick)
    );

    // 4 位 BCD 计数器：0000~9999 循环递增
    bcd_counter u_cnt(
        .clk   (clk),
        .rst_n (clr_),
        .en    (inc_tick & start),
        .data  (data)
    );

    // 数码管动态扫描显示
    Display #(.DIGITS(4)) u_disp(
        .clk       (clk),
        .rst_n     (1'b1),
        .scan_tick (scan_tick),
        .data      (data),
        .which     (which),
        .seg       (seg)
    );

    assign led    = data;
    assign enable = 1'b1;

endmodule
