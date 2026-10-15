`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/09 16:30:00
// Design Name:
// Module Name: data_mem
// Project Name: project_12
// Target Devices: xc7a100tfgg484-2L (HDU-XL-01)
// Tool Versions: Vivado 2018.3
// Description: 存储器模块（Memory IP 核 RAM_B 的封装）
//              IP 配置：单端口，32 位宽 x 64 深，带字节写使能（Byte_Size=8）
//              等效 256x8 位物理存储器；按字节编址（8 位地址），按字（32 位）访问
//              字地址 = 字节地址[7:2]，字内字节偏移 = 字节地址[1:0]
//              小端存储：数据低字节对应低地址（由 IP 字节使能实现）
//              按字访问须 4 字节边界对齐（ByteAddr[1:0] == 0）
//
//////////////////////////////////////////////////////////////////////////////////


module data_mem(
    clk,
    MemWrite,
    ByteAddr,
    WriteData,
    ReadData,
    aligned
    );

    input             clk;
    input             MemWrite;        // 存储器写使能
    input      [7:0]  ByteAddr;        // 字节地址（地址线 8 位）
    input      [31:0] WriteData;       // 写入数据
    output     [31:0] ReadData;        // 读出数据
    output            aligned;         // 访问是否边界对齐

    assign aligned = (ByteAddr[1:0] == 2'b00);        // 按字访问须 4 字节对齐

    wire [5:0] word_addr = ByteAddr[7:2];             // 字节地址 -> 字地址
    wire       we        = MemWrite & aligned;        // 未对齐时不写入
    wire [3:0] wea       = {4{we}};                   // 整字写：4 个字节使能同时有效

    RAM_B u_ram(
        .clka  (clk),
        .wea   (wea),
        .addra (word_addr),
        .dina  (WriteData),
        .douta (ReadData)
    );

endmodule
