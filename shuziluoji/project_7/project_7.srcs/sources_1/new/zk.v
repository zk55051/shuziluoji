`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/08 15:48:45
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
   PRE, CLR, CLK, D, Q1, Q2
);
    input wire PRE, CLR, CLK, D;
    output reg Q1, Q2;

    
    always @(posedge CLK or negedge PRE or negedge CLR) begin
        
        if (!PRE && !CLR) begin
            Q1 <= 1'b0;
            Q2 <= 1'b0;
        end
        
        else if (!PRE && CLR) begin
            Q1 <= 1'b1;
            Q2 <= 1'b0;
        end
        
        else if (PRE && !CLR) begin
            Q1 <= 1'b0;
            Q2 <= 1'b1;
        end
        
        else begin
            Q1 <= D;
            Q2 <= ~D;
        end
    end

endmodule
