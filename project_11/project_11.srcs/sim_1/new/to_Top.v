`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: to_Top
// Project Name: project_11
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 数字钟顶层仿真测试
//              缩小分频系数：DIV_1HZ=10（100ns 计一秒），DIV_DB=3（按键消抖）
//
//////////////////////////////////////////////////////////////////////////////////


module to_Top();

    reg         clk;
    reg  [31:0] sw;
    reg  [6:1]  swb;
    wire [23:0] led;
    wire [7:0]  seg;
    wire [2:0]  which;
    wire        enable;

    Top #(.DIV_1HZ(10), .DIV_SCAN(4), .DIV_DB(3)) dut(
        .clk    (clk),
        .sw     (sw),
        .swb    (swb),
        .led    (led),
        .seg    (seg),
        .which  (which),
        .enable (enable)
    );

    initial begin
        clk = 1'b0;
        sw  = 32'd0;
        swb = 6'b100000;               // swb[6]=1 -> 上电复位
    end

    always #5 clk = ~clk;              // 100MHz 时钟

    // 打印时间变化
    reg [23:0] t_prev;
    initial t_prev = 24'h0;
    always @(posedge clk) begin
        if (led !== t_prev) begin
            $display("[%0t] time = %0d%0d:%0d%0d:%0d%0d", $time,
                     led[23:20], led[19:16], led[15:12], led[11:8], led[7:4], led[3:0]);
            t_prev <= led;
        end
    end

    initial begin
        // 复位释放
        #100;
        swb[6] = 1'b0;

        // 启动计时，观察秒计数与进位
        sw[0] = 1'b1;
        #7000;

        // 停止，时间应保持不变
        sw[0] = 1'b0;
        #500;

        // 校时：进入校时模式，选中"时"字段并 +1
        sw[2] = 1'b1;
        #200;
        swb[1] = 1'b1; #100; swb[1] = 1'b0; #100;    // 字段 0 -> 1
        swb[1] = 1'b1; #100; swb[1] = 1'b0; #100;    // 字段 1 -> 2 (时)
        swb[2] = 1'b1; #100; swb[2] = 1'b0; #200;    // 时 +1

        // 显示日期
        sw[2] = 1'b0;
        sw[1] = 1'b1;
        #300;
        $display("[%0t] date = %0d%0d:%0d%0d:%0d%0d", $time,
                 dut.date_out[23:20], dut.date_out[19:16],
                 dut.date_out[15:12], dut.date_out[11:8],
                 dut.date_out[7:4],   dut.date_out[3:0]);

        $display("[%0t] simulation finished", $time);
        $stop;
    end

endmodule
