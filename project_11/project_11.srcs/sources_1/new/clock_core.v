`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: clock_core
// Project Name: project_11
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 数字钟核心：时/分/秒 计时 + 年/月/日 计数 + 校时
//              tick_1hz 为 1Hz 计时脉冲；run 为启动/停止；set 为校时使能
//              field 选择校时字段(0秒 1分 2时 3日 4月 5年)，inc 为校时 +1 脉冲
//              停止后再次启动，从当前值继续计时（不清零）
//
//////////////////////////////////////////////////////////////////////////////////


module clock_core(
    clk,
    rst_n,
    tick_1hz,
    run,
    set,
    field,
    inc,
    time_out,
    date_out
    );

    input             clk;
    input             rst_n;
    input             tick_1hz;        // 1Hz 计时脉冲
    input             run;             // 启动/停止
    input             set;             // 校时使能
    input      [2:0]  field;           // 校时字段选择
    input             inc;             // 校时 +1 脉冲
    output     [23:0] time_out;        // {时, 分, 秒}
    output     [23:0] date_out;        // {年, 月, 日}

    wire counting = run & ~set;        // 正常计时（停止或校时时冻结）

    wire [7:0] sec, min, hr, day, mon, yr;
    wire c_sec, c_min, c_hr, c_day, c_mon, c_yr;

    // 各字段计数使能：校时时只对选中字段 +1，且不向上进位
    wire sec_en = set ? ((field == 3'd0) & inc) : (tick_1hz & counting);
    wire min_en = set ? ((field == 3'd1) & inc) : c_sec;
    wire hr_en  = set ? ((field == 3'd2) & inc) : c_min;
    wire day_en = set ? ((field == 3'd3) & inc) : c_hr;
    wire mon_en = set ? ((field == 3'd4) & inc) : c_day;
    wire yr_en  = set ? ((field == 3'd5) & inc) : c_mon;

    bcd_cnt #(.MAX(59), .INIT(0)) u_sec(.clk(clk), .rst_n(rst_n), .en(sec_en), .q(sec), .carry(c_sec));
    bcd_cnt #(.MAX(59), .INIT(0)) u_min(.clk(clk), .rst_n(rst_n), .en(min_en), .q(min), .carry(c_min));
    bcd_cnt #(.MAX(23), .INIT(0)) u_hr (.clk(clk), .rst_n(rst_n), .en(hr_en ), .q(hr ), .carry(c_hr ));
    bcd_cnt #(.MAX(31), .INIT(1)) u_day(.clk(clk), .rst_n(rst_n), .en(day_en), .q(day), .carry(c_day));
    bcd_cnt #(.MAX(12), .INIT(1)) u_mon(.clk(clk), .rst_n(rst_n), .en(mon_en), .q(mon), .carry(c_mon));
    bcd_cnt #(.MAX(99), .INIT(0)) u_yr (.clk(clk), .rst_n(rst_n), .en(yr_en ), .q(yr ), .carry(c_yr ));

    assign time_out = {hr, min, sec};
    assign date_out = {yr, mon, day};

endmodule
