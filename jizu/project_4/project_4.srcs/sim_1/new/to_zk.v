`timescale 1ns / 1ps

module to_zk();

    reg clk;
    reg [31:0] sw;
    reg [6:1] swb;
    wire [31:0] led;
    wire [7:0] seg;
    wire [2:0] which;
    wire enable;

    Top uut(
        .clk(clk),
        .sw(sw),
        .swb(swb),
        .led(led),
        .seg(seg),
        .which(which),
        .enable(enable)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task press_key;
        input integer key_id;
        begin
            swb[key_id] = 1'b1;
            repeat (20) @(posedge clk);
            swb[key_id] = 1'b0;
            repeat (20) @(posedge clk);
        end
    endtask

    task set_addr;
        input [4:0] r_addr_a;
        input [4:0] r_addr_b;
        input [4:0] w_addr;
        begin
            sw[31:27] = r_addr_a;
            sw[26:22] = r_addr_b;
            sw[21:17] = w_addr;
        end
    endtask

    task load_data;
        input [31:0] data;
        begin
            sw = data;
            press_key(3);
        end
    endtask

    task write_reg;
        begin
            press_key(2);
        end
    endtask

    task check_data;
        input [31:0] data;
        input [31:0] expect;
        input [8*48:1] msg;
        begin
            if (data == expect)
                $display("PASS: %0s", msg);
            else
                $display("FAIL: %0s, expect=%h, get=%h", msg, expect, data);
        end
    endtask

    initial begin
        $display("=== Top Board Testbench Started ===");

        sw = 32'd0;
        swb = 6'd0;
        repeat (4) @(posedge clk);

        press_key(1);
        set_addr(5'd0, 5'd0, 5'd0);
        repeat (4) @(posedge clk);
        check_data(led, 32'd0, "reset clears LED output");

        load_data(32'h89ab_cdef);
        set_addr(5'd5, 5'd5, 5'd5);
        write_reg();
        repeat (4) @(posedge clk);
        check_data(led, 32'h89ab_cdef, "latched 32-bit data writes R5 and LED reads R5");
        check_data(uut.R_Data_A, 32'h89ab_cdef, "direct address selects R5 on port A");

        wait (which == 3'd7);
        repeat (2) @(posedge clk);
        if (seg == 8'b0111_0001 && enable == 1'b1)
            $display("PASS: seven segment scans port A low nibble");
        else
            $display("FAIL: seven segment, expect digit f seg=01110001 enable=1, get seg=%b enable=%b", seg, enable);

        load_data(32'hffff_ffff);
        set_addr(5'd7, 5'd7, 5'd7);
        write_reg();
        repeat (4) @(posedge clk);
        check_data(led, 32'hffff_ffff, "all 32 switch data bits write R7");

        load_data(32'hffff_ffff);
        set_addr(5'd0, 5'd0, 5'd0);
        write_reg();
        repeat (4) @(posedge clk);
        check_data(led, 32'd0, "R0 keeps zero");

        press_key(1);
        set_addr(5'd5, 5'd5, 5'd5);
        repeat (4) @(posedge clk);
        check_data(led, 32'd0, "reset clears R5 through Top");
        check_data(uut.R_Data_A, 32'd0, "reset clears R5 on port A");

        $display("=== Top Board Testbench Completed ===");
        $finish;
    end

endmodule
