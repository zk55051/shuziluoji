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
        input [7:0] addr;
        begin
            sw[10:3] = addr;
        end
    endtask

    task set_data_sel;
        input [2:0] data_sel;
        begin
            sw[2:0] = data_sel;
        end
    endtask

    task write_mem;
        input [7:0] addr;
        input [2:0] data_sel;
        begin
            set_addr(addr);
            set_data_sel(data_sel);
            press_key(2);
        end
    endtask

    task read_mem;
        input [7:0] addr;
        begin
            set_addr(addr);
            repeat (4) @(posedge clk);
        end
    endtask

    task check_data;
        input [31:0] data;
        input [31:0] expect;
        input [8*60:1] msg;
        begin
            if (data == expect)
                $display("PASS: %0s", msg);
            else
                $display("FAIL: %0s, expect=%h, get=%h", msg, expect, data);
        end
    endtask

    initial begin
        $display("=== Project 5 Memory Testbench Started ===");

        sw = 32'd0;
        swb = 6'd0;
        repeat (4) @(posedge clk);

        press_key(1);
        read_mem(8'h00);
        check_data(led, 32'h00000820, "read initial word address 00");

        read_mem(8'h04);
        check_data(led, 32'h00632020, "read initial word address 04");

        read_mem(8'h1c);
        check_data(led, 32'h99999999, "read initial word address 1c");

        write_mem(8'h08, 3'd2);
        read_mem(8'h08);
        check_data(led, 32'hdead_beef, "write and read word address 08");

        write_mem(8'h0c, 3'd3);
        read_mem(8'h0c);
        check_data(led, 32'hcafe_babe, "write and read word address 0c");

        write_mem(8'h10, 3'd7);
        read_mem(8'h10);
        check_data(led, 32'hffff_ffff, "write and read word address 10");

        read_mem(8'h0c);
        wait (which == 3'd7);
        repeat (2) @(posedge clk);
        if (seg == 8'b0110_0001 && enable == 1'b1)
            $display("PASS: seven segment scans low nibble e");
        else
            $display("FAIL: seven segment, expect e seg=01100001 enable=1, get seg=%b enable=%b", seg, enable);

        $display("=== Project 5 Memory Testbench Completed ===");
        $finish;
    end

endmodule
