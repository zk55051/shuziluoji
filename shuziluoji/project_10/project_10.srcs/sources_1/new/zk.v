`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/21 21:03:31
// Design Name: 
// Module Name: zk
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


module zk(
    MR,
    EN,
    CLK,
    Q,
    CO
    );
    input MR,EN,CLK;
    output reg [3:0]Q;
    output reg CO;
    
    always @(posedge CLK or negedge MR) begin
        if(!MR) begin
            Q<=4'b0;
            CO<=1'b0;
        end
        else begin
            if(!EN) begin
                Q<=Q;
                CO<=CO;
            end
            else begin
                CO <= (Q==4'b0)?1'b1:1'b0;
                Q<= (Q==4'b0)?4'b1001:Q-1'b1;
            end
        end
    end
    
    initial begin
        Q=4'b0;
        CO=1'b1;
    end
    
endmodule
