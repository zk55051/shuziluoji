`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: to_Top
// Project Name: project_12
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 简单计算机顶层仿真测试
//              1) 验证存储器 COE 预置数据；
//              2) 按板上操作方式，用 ADD 从存储器把数据装载进寄存器；
//              3) 验证 Ri θ mem[1] -> Rj 的各种 ALU 功能
//
//////////////////////////////////////////////////////////////////////////////////


module to_Top();

    reg         clk;
    reg  [31:0] sw;
    reg  [6:1]  swb;
    wire [31:0] led;
    wire [7:0]  seg;
    wire [2:0]  which;
    wire        enable;

    Top #(.DIV_SCAN(4)) dut(
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

    // 设置控制开关
    task set_ctl(input [3:0] op, input [4:0] ri, input [4:0] rj,
                 input [7:0] addr, input rw, input mw, input mr);
        begin
            sw[3:0]   = op;
            sw[8:4]   = ri;
            sw[13:9]  = rj;
            sw[21:14] = addr;
            sw[22]    = rw;
            sw[23]    = mw;
            sw[24]    = mr;
        end
    endtask

    // 执行一次 Ri θ (addr) -> Rj
    task do_op(input [3:0] op, input [4:0] rj, input [31:0] expect);
        begin
            set_ctl(op, 5'd1, rj, 8'h04, 1'b1, 1'b0, 1'b1);   // A=R1(240), B=mem[1](60)
            repeat (3) @(posedge clk);
            sw[22] = 1'b0;
            @(posedge clk);
            $display("[%0t] ALU_op=%b  R%0d <- R1(240) op mem[1](60) = %0d (0x%08h)  期望 %0d",
                     $time, op, rj, dut.u_reg.regs[rj], dut.u_reg.regs[rj], expect);
        end
    endtask

    initial begin
        // 复位释放
        #100;
        swb[6] = 1'b0;
        #20;

        // ---- 1) 验证存储器 COE 预置 ----
        set_ctl(4'b0100, 5'd0, 5'd0, 8'h04, 1'b0, 1'b0, 1'b1);  // 读 word1
        repeat (3) @(posedge clk);
        $display("[%0t] mem[1] = %0d (COE 期望 60)", $time, dut.MemRaw);
        set_ctl(4'b0100, 5'd0, 5'd0, 8'h0C, 1'b0, 1'b0, 1'b1);  // 读 word3
        repeat (3) @(posedge clk);
        $display("[%0t] mem[3] = %0d (COE 期望 240)", $time, dut.MemRaw);

        // ---- 2) 板上初始化方式：R1 <- mem[3] = 240 ----
        set_ctl(4'b0100, 5'd0, 5'd1, 8'h0C, 1'b1, 1'b0, 1'b1);  // ADD, Ri=0(0), 写 R1
        repeat (3) @(posedge clk);
        sw[22] = 1'b0;
        @(posedge clk);
        $display("[%0t] 装载 R1 <- mem[3] = %0d", $time, dut.u_reg.regs[1]);

        // ---- 3) 验证 Ri θ mem[1] -> Rj ----
        do_op(4'b0100, 5'd5,  32'd300);            // ADD  240+60
        do_op(4'b0101, 5'd6,  32'd180);            // SUB  240-60
        do_op(4'b0000, 5'd7,  32'd48);             // AND  0xF0 & 0x3C
        do_op(4'b0001, 5'd8,  32'd252);            // OR   0xF0 | 0x3C
        do_op(4'b0010, 5'd9,  32'd204);            // XOR  0xF0 ^ 0x3C
        do_op(4'b0011, 5'd10, 32'hFFFFFF03);       // NOR  ~(0xF0|0x3C)
        do_op(4'b0110, 5'd11, 32'd0);              // SLT  240 < 60 ? 0
        do_op(4'b0111, 5'd12, 32'd3932160);        // SHL  60 << 16 = 0x3C0000
        do_op(4'b1000, 5'd13, 32'd0);              // 保留功能 -> 0

        $display("[%0t] simulation finished", $time);
        $stop;
    end

endmodule
