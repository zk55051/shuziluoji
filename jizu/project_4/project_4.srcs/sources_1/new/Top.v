`timescale 1ns / 1ps

module Top(
    clk,
    sw,
    swb,
    led,
    seg,
    which,
    enable
);

    input wire clk;
    input wire [31:0] sw;
    input wire [6:1] swb;
    output wire [31:0] led;
    output wire [7:0] seg;
    output wire [2:0] which;
    output wire enable;

    wire reset_;
    wire Write_Reg;
    wire write_btn;
    wire load_btn;

    wire [4:0] R_Addr_A;
    wire [4:0] R_Addr_B;
    wire [4:0] W_Addr;
    reg [31:0] data_reg;
    wire [31:0] W_Data;

    wire [31:0] R_Data_A;
    wire [31:0] R_Data_B;
    wire [14:0] display_count;
    wire [3:0] display_digit;

    assign reset_ = ~swb[1];

    assign R_Addr_A = sw[31:27];
    assign R_Addr_B = sw[26:22];
    assign W_Addr = sw[21:17];

    dalay write_delay(
        .clk(clk),
        .in(swb[2]),
        .out(write_btn)
    );

    dalay load_delay(
        .clk(clk),
        .in(swb[3]),
        .out(load_btn)
    );

    reg write_d1, write_d2;
    reg load_d1, load_d2;

    always @(posedge clk or negedge reset_) begin
        if (!reset_) begin
            write_d1 <= 1'b0;
            write_d2 <= 1'b0;
            load_d1 <= 1'b0;
            load_d2 <= 1'b0;
        end
        else begin
            write_d1 <= write_btn;
            write_d2 <= write_d1;
            load_d1 <= load_btn;
            load_d2 <= load_d1;
        end
    end

    assign Write_Reg = write_d1 & ~write_d2;
    wire Load_Data;

    assign Load_Data = load_d1 & ~load_d2;

    always @(posedge clk or negedge reset_) begin
        if (!reset_) begin
            data_reg <= 32'b0;
        end
        else begin
            if (Load_Data)
                data_reg <= sw;
        end
    end

    assign W_Data = data_reg;

    zk Reg(
        .clk(clk),
        .reset_(reset_),
        .R_Addr_A(R_Addr_A),
        .R_Addr_B(R_Addr_B),
        .W_Addr(W_Addr),
        .W_Data(W_Data),
        .Write_Reg(Write_Reg),
        .R_Data_A(R_Data_A),
        .R_Data_B(R_Data_B)
    );

    assign led = R_Data_B;

    Display display(
        .clk(clk),
        .data(R_Data_A),
        .which(which),
        .seg(seg),
        .count(display_count),
        .digit(display_digit)
    );

    assign enable = 1'b1;

endmodule
