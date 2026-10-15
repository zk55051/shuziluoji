`timescale 1ns / 1ps

module Display(
    clk,
    data,
    which,
    seg,
    count,
    digit
);
    input clk;
    input [31:0] data;
    output reg [2:0] which = 3'd0;
    output reg [7:0] seg;
    output reg [14:0] count = 15'd0;
    output reg [3:0] digit;

always @(posedge clk)
    count <= count + 1'b1;

always @(negedge clk)
    if (&count)
        which <= which + 1'b1;

always @(*) begin
    case (which)
        3'd0: digit = data[31:28];
        3'd1: digit = data[27:24];
        3'd2: digit = data[23:20];
        3'd3: digit = data[19:16];
        3'd4: digit = data[15:12];
        3'd5: digit = data[11:8];
        3'd6: digit = data[7:4];
        3'd7: digit = data[3:0];
        default: digit = 4'h0;
    endcase
end

always @(*) begin
    case (digit)
        4'h0: seg = 8'b0000_0011;
        4'h1: seg = 8'b1001_1111;
        4'h2: seg = 8'b0010_0101;
        4'h3: seg = 8'b0000_1101;
        4'h4: seg = 8'b1001_1001;
        4'h5: seg = 8'b0100_1001;
        4'h6: seg = 8'b0100_0001;
        4'h7: seg = 8'b0001_1111;
        4'h8: seg = 8'b0000_0001;
        4'h9: seg = 8'b0000_1001;
        4'ha: seg = 8'b0001_0001;
        4'hb: seg = 8'b1100_0001;
        4'hc: seg = 8'b0110_0011;
        4'hd: seg = 8'b1000_0101;
        4'he: seg = 8'b0110_0001;
        4'hf: seg = 8'b0111_0001;
        default: seg = 8'b1111_1111;
    endcase
end

endmodule
