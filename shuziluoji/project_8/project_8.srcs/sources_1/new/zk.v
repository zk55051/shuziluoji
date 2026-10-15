`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/15 14:02:25
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
    CLK,
    J,
    K,
    Q1,
    Q2
    );
    input wire CLK,J,K;
    output reg Q1,Q2;
    
    always@(posedge CLK) begin
        case({J,K})
          2'b00:;
          2'b01:{Q1,Q2}=2'b01;
          2'b10:{Q1,Q2}=2'b10;
          2'b11:{Q1,Q2}={Q2,Q1};
        endcase
    end
    
endmodule
