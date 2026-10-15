`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: to_Top
// Project Name: project_13
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 数码管扫描显示顶层模块仿真测试
//              缩小分频系数以便仿真：DIV_INC=10（10 个时钟自增一次）
//
//////////////////////////////////////////////////////////////////////////////////


module to_Top();

    reg         clk;
    reg  [31:0] sw;
    wire [15:0] led;
    wire [7:0]  seg;
    wire [2:0]  which;
    wire        enable;

    Top #(.DIV_INC(10), .DIV_SCAN(4)) dut(
        .clk    (clk),
        .sw     (sw),
        .led    (led),
        .seg    (seg),
        .which  (which),
        .enable (enable)
    );

    initial begin
        clk = 1'b0;
        sw  = 32'd0;
    end

    always #5 clk = ~clk;              // 100MHz 时钟，周期 10ns

    // 打印计数值变化，便于观察自增/停止/清零
    reg [15:0] led_prev;
    initial led_prev = 16'h0000;
    always @(posedge clk) begin
        if (led !== led_prev) begin
            $display("[%0t] data = %0d%0d%0d%0d", $time,
                     led[15:12], led[11:8], led[7:4], led[3:0]);
            led_prev <= led;
        end
    end

    initial begin
        // 1) 清零：sw[1]=0 -> 显示 0000
        sw[1] = 1'b0;
        sw[0] = 1'b0;
        #200;

        // 2) 释放清零并启动自增
        sw[1] = 1'b1;
        sw[0] = 1'b1;
        #2000;                          // 观察 data 递增

        // 3) 停止自增，数值保持不变
        sw[0] = 1'b0;
        #500;

        // 4) 再次清零
        sw[1] = 1'b0;
        #200;

        $display("[%0t] simulation finished", $time);
        $stop;
    end

endmodule
