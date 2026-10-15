`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/21 22:29:24
// Design Name: 
// Module Name: to_zk
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module to_zk();

reg MR,EN,CLK;
wire [3:0]Q;
wire CO;

initial begin
    {MR,EN}=2'b0;
    CLK=1'b0;
    
end

always #10 CLK=CLK+1'b1;
always #50 {MR,EN}={MR,EN}+1'b1;


zk utt(.MR(MR),.EN(EN),.CLK(CLK),.Q(Q),.CO(CO));

endmodule
