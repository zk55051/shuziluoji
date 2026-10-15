`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/30 20:47:32
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
    C,B,A,G1,G2A,G2B,Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7
    );
    input wire  C,B,A,G1,G2A,G2B;
    output reg Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7;
    
    
    
    always @(*)
        begin
            if(G1 & (~G2A) & (~G2B))
                begin
                    case({C,B,A})
                        3'b000:{Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0}=8'b11111110;
                        3'b001:{Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0}=8'b11111101;
                        3'b010:{Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0}=8'b11111011;
                        3'b011:{Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0}=8'b11110111;
                        3'b100:{Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0}=8'b11101111;
                        3'b101:{Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0}=8'b11011111;
                        3'b110:{Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0}=8'b10111111;
                        3'b111:{Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0}=8'b01111111;
                        default:{Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0}=8'b11111111;
                    endcase
                end
            else {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0}=8'b11111111;          
        end            
endmodule
