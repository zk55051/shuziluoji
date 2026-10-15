`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: Top
// Project Name: project_11
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 综合实验二 数字钟
//              基本功能：计时 时/分/秒，6 位数码管显示 HH:MM:SS
//              附加功能：启动/停止、校时(设置时间)、显示日期、设置日期
//              sw[0]  : 启动/停止（=1 计时，=0 暂停，从当前值继续）
//              sw[1]  : 显示选择（=0 时间 HH:MM:SS，=1 日期 YY:MM:DD）
//              sw[2]  : 校时使能（=1 进入校时）
//              swb[1] : 选择要校时的字段（秒->分->时->日->月->年 循环）
//              swb[2] : 选中字段 +1
//              swb[6] : 复位（按下为 1，低有效复位内部 rst_n）
//              clk    : 系统 100MHz 时钟
//
//////////////////////////////////////////////////////////////////////////////////


module Top #(
    parameter DIV_1HZ  = 100_000_000,   // 100MHz -> 1Hz 计时脉冲
    parameter DIV_SCAN = 100_000,       // 100MHz -> 1kHz 位切换（6 位刷新率约 167Hz）
    parameter DIV_DB   = 1_000_000      // 按键消抖（100MHz 下 1M = 10ms）
    )(
    clk,
    sw,
    swb,
    led,
    seg,
    which,
    enable
    );

    input              clk;            // 系统时钟 100MHz
    input       [31:0] sw;             // 拨动开关
    input       [6:1]  swb;            // 按键
    output      [23:0] led;            // 显示当前时间（调试用）
    output      [7:0]  seg;            // 段选
    output      [2:0]  which;          // 位选
    output             enable;         // 3:8 译码器使能

    wire rst_n = ~swb[6];              // 按下 swb[6] 复位
    wire run       = sw[0];            // 启动/停止
    wire date_mode = sw[1];            // 显示选择
    wire set       = sw[2];            // 校时使能

    wire tick_1hz;
    wire scan_tick;

    // 1Hz 计时脉冲
    freq_div #(.DIV(DIV_1HZ)) u_1hz(
        .clk   (clk),
        .rst_n (rst_n),
        .tick  (tick_1hz)
    );

    // 动态扫描分频
    freq_div #(.DIV(DIV_SCAN)) u_scan(
        .clk   (clk),
        .rst_n (rst_n),
        .tick  (scan_tick)
    );

    // 按键消抖
    wire sel_level, inc_level;
    delay #(.DIV(DIV_DB)) db_sel(.clk(clk), .in(swb[1]), .out(sel_level));
    delay #(.DIV(DIV_DB)) db_inc(.clk(clk), .in(swb[2]), .out(inc_level));

    // 上升沿检测：每次按键产生一个单周期脉冲
    reg sel_d, inc_d;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sel_d <= 1'b0;
            inc_d <= 1'b0;
        end
        else begin
            sel_d <= sel_level;
            inc_d <= inc_level;
        end
    end
    wire sel_pulse = sel_level & ~sel_d;
    wire inc_pulse = inc_level & ~inc_d;

    // 校时字段选择：0 秒 / 1 分 / 2 时 / 3 日 / 4 月 / 5 年
    reg [2:0] field;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            field <= 3'd0;
        else if (sel_pulse)
            field <= (field >= 3'd5) ? 3'd0 : field + 1'b1;
    end

    // 数字钟核心
    wire [23:0] time_out, date_out;
    clock_core u_core(
        .clk      (clk),
        .rst_n    (rst_n),
        .tick_1hz (tick_1hz),
        .run      (run),
        .set      (set),
        .field    (field),
        .inc      (inc_pulse),
        .time_out (time_out),
        .date_out (date_out)
    );

    wire [23:0] disp = date_mode ? date_out : time_out;

    // 6 位数码管动态扫描显示
    Display #(.DIGITS(6)) u_disp(
        .clk       (clk),
        .rst_n     (rst_n),
        .scan_tick (scan_tick),
        .data      (disp),
        .which     (which),
        .seg       (seg)
    );

    assign led    = time_out;
    assign enable = 1'b1;

endmodule
