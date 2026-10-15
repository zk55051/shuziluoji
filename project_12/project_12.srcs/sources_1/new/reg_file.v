`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: reg_file
// Project Name: project_12
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 32 x 32 位三端口寄存器堆（2 个读端口，1 个写端口）
//              读端口 A/B 为组合读出；写端口在时钟上升沿写入（WriteEn 有效）
//              寄存器地址 5 位；复位后所有寄存器清零
//
//////////////////////////////////////////////////////////////////////////////////


module reg_file(
    clk,
    rst_n,
    ReadAddrA,
    ReadDataA,
    ReadAddrB,
    ReadDataB,
    WriteEn,
    WriteAddr,
    WriteData
    );

    input             clk;
    input             rst_n;

    input      [4:0]  ReadAddrA;       // 读端口 A 地址
    output     [31:0] ReadDataA;       // 读端口 A 数据
    input      [4:0]  ReadAddrB;       // 读端口 B 地址
    output     [31:0] ReadDataB;       // 读端口 B 数据

    input             WriteEn;         // 写使能
    input      [4:0]  WriteAddr;       // 写地址
    input      [31:0] WriteData;       // 写数据

    reg [31:0] regs [0:31];
    integer    k;

    initial begin
        for (k = 0; k < 32; k = k + 1)
            regs[k] = 32'd0;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (k = 0; k < 32; k = k + 1)
                regs[k] <= 32'd0;
        end
        else if (WriteEn) begin
            regs[WriteAddr] <= WriteData;
        end
    end

    // 两个组合读端口
    assign ReadDataA = regs[ReadAddrA];
    assign ReadDataB = regs[ReadAddrB];

endmodule
