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
    wire write_btn;
    wire Mem_Write;
    wire Mem_Read;

    wire [7:0] Mem_Addr;
    reg [31:0] M_W_Data;
    wire [31:0] M_R_Data;
    wire [14:0] display_count;
    wire [3:0] display_digit;

    assign reset_ = ~swb[1];
    assign Mem_Addr = sw[10:3];
    assign Mem_Read = ~Mem_Write;

    dalay write_delay(
        .clk(clk),
        .in(swb[2]),
        .out(write_btn)
    );

    reg write_d1, write_d2;

    always @(posedge clk) begin
        if (!reset_) begin
            write_d1 <= 1'b0;
            write_d2 <= 1'b0;
        end
        else begin
            write_d1 <= write_btn;
            write_d2 <= write_d1;
        end
    end

    assign Mem_Write = write_d1 & ~write_d2;

    always @(*) begin
        case (sw[2:0])
            3'd0: M_W_Data = 32'h13572468;
            3'd1: M_W_Data = 32'h24681357;
            3'd2: M_W_Data = 32'hdeadbeef;
            3'd3: M_W_Data = 32'hcafebabe;
            3'd4: M_W_Data = 32'h55aa55aa;
            3'd5: M_W_Data = 32'ha5a5a5a5;
            3'd6: M_W_Data = 32'h00000000;
            3'd7: M_W_Data = 32'hffffffff;
            default: M_W_Data = 32'b0;
        endcase
    end

    zk Data_Mem(
        .clk_m(clk),
        .Mem_Write(Mem_Write),
        .Mem_Read(Mem_Read),
        .Mem_Addr(Mem_Addr),
        .M_W_Data(M_W_Data),
        .M_R_Data(M_R_Data)
    );

    assign led = M_R_Data;

    Display display(
        .clk(clk),
        .data(M_R_Data),
        .which(which),
        .seg(seg),
        .count(display_count),
        .digit(display_digit)
    );

    assign enable = 1'b1;

endmodule
