`timescale 1ns / 1ps

module zk(
    clk_m,
    Mem_Write,
    Mem_Read,
    Mem_Addr,
    M_W_Data,
    M_R_Data
);

    input wire clk_m;
    input wire Mem_Write;
    input wire Mem_Read;
    input wire [7:0] Mem_Addr;
    input wire [31:0] M_W_Data;
    output wire [31:0] M_R_Data;

    wire [0:0] wea;
    wire [31:0] ram_dout;

    assign wea = {Mem_Write};
    assign M_R_Data = Mem_Read ? ram_dout : 32'b0;

    RAM_B Data_RAM(
        .clka(clk_m),
        .wea(wea),
        .addra(Mem_Addr[7:2]),
        .dina(M_W_Data),
        .douta(ram_dout)
    );

endmodule
