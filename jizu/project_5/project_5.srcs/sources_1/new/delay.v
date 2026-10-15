`timescale 1ns / 1ps

module dalay(
    clk,
    in,
    out
    );
    input clk,in;
    output reg out;

   localparam DELAY_MAX = 24'd10;

   reg [23:0] cnt;
   reg temp;

initial begin
    cnt = 24'd0;
    temp = 1'b0;
    out = 1'b0;
end

always @(posedge clk) begin
    temp<=in;
end

always @(posedge clk) begin
    if (in != temp) begin
        cnt <= 24'd0;
    end else begin
        if (cnt < DELAY_MAX) begin
            cnt <= cnt + 1'b1;
        end
    end
end

always @(posedge clk) begin
    if (cnt >= DELAY_MAX) begin
        out <= in;
    end
end

endmodule
