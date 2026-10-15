`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/15 15:50:22
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
    Load,
    EN,
    CLK, 
    D,
    Q,
    CO
    );
    input wire MR, Load,EN,CLK;
    input wire [3:0]D;
    output reg [3:0]Q;
    output reg CO;
    
    always @(negedge MR or posedge CLK ) begin
        
        if (!MR) begin
            Q <= 4'b0;  
            CO <= 1'b0;
        end
       
        else begin
            if (!Load) begin
                Q <= D;
                CO <= CO;
            end
            
           else if (!EN) begin
                Q <= Q;
                CO <= CO;
            end
            else begin
                
                 //CO <= CO+1'b1;
                 Q<=Q+1'b1;
                 CO<= (Q == 4'b1110) ? 1'b1 : 1'b0;
            end
        end
    end

endmodule
