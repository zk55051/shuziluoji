`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/21 21:16:54
// Design Name: 
// Module Name: delay
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


module delay(
    clk,
    in,
    out
    );
    input clk,in;
    output reg out;
    
   reg [23:0] cnt;           
   reg temp;         


always @(posedge clk) begin
    temp<=in;  
end

always @(posedge clk) begin
    if (in != temp) begin  
        cnt <= 24'd0;                
    end else begin                   
        if (cnt < 24'd10000000) begin  
            cnt <= cnt + 1'b1;
        end
    end
end

always @(posedge clk) begin
    if (cnt >= 24'd10000000) begin  
        out <= in;        
    end
end

endmodule

