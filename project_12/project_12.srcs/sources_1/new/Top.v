`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: Top
// Project Name: project_12
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 综合实验三 简单计算机
//              调用 32 位 ALU、32x32 三端口寄存器堆、256x8 存储器，完成
//              Ri θ (addr) -> Rj  的操作：
//              A 口读 Ri，存储器读 (addr) 作为 B，ALU 运算结果写回 Rj
//
//              开关分配：
//              sw[3:0]   : ALU_op      运算功能选择
//              sw[8:4]   : Ri          读端口 A 寄存器地址
//              sw[13:9]  : Rj          写端口寄存器地址
//              sw[21:14] : MemAddr     存储器字节地址（须 4 字节对齐）
//              sw[22]    : RegWrite    寄存器写使能
//              sw[23]    : MemWrite    存储器写使能（写入数据 = ALU 结果）
//              sw[24]    : MemRead     存储器读使能（作 B 操作数）
//              sw[29:25] : Rb          读端口 B 寄存器地址（观察用）
//              swb[6]    : 复位
//
//////////////////////////////////////////////////////////////////////////////////


module Top #(
    parameter DIV_SCAN = 100_000       // 数码管扫描分频：100MHz -> 1kHz
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
    output      [31:0] led;            // 显示 ALU 结果 F
    output      [7:0]  seg;            // 段选
    output      [2:0]  which;          // 位选
    output             enable;         // 3:8 译码器使能

    wire rst_n = ~swb[6];

    // 控制信号
    wire [3:0] ALU_op   = sw[3:0];
    wire [4:0] Ri       = sw[8:4];
    wire [4:0] Rj       = sw[13:9];
    wire [7:0] MemAddr  = sw[21:14];
    wire       RegWrite = sw[22];
    wire       MemWrite = sw[23];
    wire       MemRead  = sw[24];
    wire [4:0] Rb       = sw[29:25];

    wire [31:0] ReadDataA, ReadDataB;
    wire [31:0] MemRaw, MemData;
    wire [31:0] F;
    wire        ZF, OF;
    wire        mem_aligned;

    // 寄存器堆：读 Ri 作为 A 操作数，写回 Rj
    reg_file u_reg(
        .clk       (clk),
        .rst_n     (rst_n),
        .ReadAddrA (Ri),
        .ReadDataA (ReadDataA),
        .ReadAddrB (Rb),
        .ReadDataB (ReadDataB),
        .WriteEn   (RegWrite),
        .WriteAddr (Rj),
        .WriteData (F)
    );

    // 存储器：字节编址、按字访问，写入数据取 ALU 结果
    data_mem u_mem(
        .clk       (clk),
        .MemWrite  (MemWrite),
        .ByteAddr  (MemAddr),
        .WriteData (F),
        .ReadData  (MemRaw),
        .aligned   (mem_aligned)
    );

    assign MemData = MemRead ? MemRaw : 32'd0;   // 读使能有效时 B 取存储器数据

    // ALU：A 来自寄存器 Ri，B 来自存储器 (addr)
    alu u_alu(
        .A      (ReadDataA),
        .B      (MemData),
        .ALU_op (ALU_op),
        .F      (F),
        .ZF     (ZF),
        .OF     (OF)
    );

    // 数码管动态扫描，以十六进制显示 ALU 结果
    wire scan_tick;
    freq_div #(.DIV(DIV_SCAN)) u_scan(
        .clk   (clk),
        .rst_n (rst_n),
        .tick  (scan_tick)
    );

    Display #(.DIGITS(8)) u_disp(
        .clk       (clk),
        .rst_n     (rst_n),
        .scan_tick (scan_tick),
        .data      (F),
        .which     (which),
        .seg       (seg)
    );

    assign led    = F;
    assign enable = 1'b1;

endmodule
