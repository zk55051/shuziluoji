`timescale 1ns / 1ps

module zk(
    clk,
    reset_,
    R_Addr_A,
    R_Addr_B,
    W_Addr,
    W_Data,
    Write_Reg,
    R_Data_A,
    R_Data_B
);

    input wire clk;
    input wire reset_;
    input wire [4:0] R_Addr_A;
    input wire [4:0] R_Addr_B;
    input wire [4:0] W_Addr;
    input wire [31:0] W_Data;
    input wire Write_Reg;
    output wire [31:0] R_Data_A;
    output wire [31:0] R_Data_B;

    reg [31:0] REG_Files [0:31];
    integer i;

    always @(posedge clk or negedge reset_) begin
        if (!reset_) begin
            for (i = 0; i < 32; i = i + 1)
                REG_Files[i] <= 32'b0;
        end
        else begin
            if (Write_Reg && W_Addr != 5'd0)
                REG_Files[W_Addr] <= W_Data;

            REG_Files[0] <= 32'b0;
        end
    end

    assign R_Data_A = (R_Addr_A == 5'd0) ? 32'b0 : REG_Files[R_Addr_A];
    assign R_Data_B = (R_Addr_B == 5'd0) ? 32'b0 : REG_Files[R_Addr_B];

endmodule
