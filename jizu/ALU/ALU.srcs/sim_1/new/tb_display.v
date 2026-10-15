`timescale 1ns / 1ps

module top_tb;

reg         clk;
reg [18:0]  sw;       // ?????? 19¦Ë????16¦Ë????+3¦Ë????
wire [9:0]  led;      // ?????? 10¦ËLED???

// ????????
top uut (
    .clk(clk),
    .sw(sw),
    .led(led)
);

// ???
always #5 clk = ~clk;

initial begin
    clk = 0;
    sw  = 19'd0;
    #10;


    // 1. ADD 5+3=8
    sw[7:0]   = 8'd5;
    sw[15:8]  = 8'd3;
    sw[18:16] = 3'b100;
    #20;

    // 2. SUB 10-4=6
    sw[7:0]   = 8'd10;
    sw[15:8]  = 8'd4;
    sw[18:16] = 3'b101;
    #20;

    // 3. AND 0xFF & 0x0F = 0x0F
    sw[7:0]   = 8'hFF;
    sw[15:8]  = 8'h0F;
    sw[18:16] = 3'b000;
    #20;

    // 4. OR 0xF0 | 0x0F = 0xFF
    sw[7:0]   = 8'hF0;
    sw[15:8]  = 8'h0F;
    sw[18:16] = 3'b001;
    #20;


    // 5. SLT 3<5 ?? 1
    sw[7:0]   = 8'd3;
    sw[15:8]  = 8'd5;
    sw[18:16] = 3'b110;
    #20;
 
    $stop;
end

endmodule