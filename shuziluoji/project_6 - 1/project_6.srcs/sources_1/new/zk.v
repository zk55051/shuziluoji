`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/01 16:15:42
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
   S,R,Q1,Q2
    );
    input wire S,R;
    output reg Q1,Q2;
    
    always @(*) begin
    if (S | R) begin   
        case ({S,R})
            2'b01: begin Q1 = 1'b0; Q2 = 1'b1; end
            2'b10: begin Q1 = 1'b1; Q2 = 1'b0; end
            2'b11: begin Q1 = 1'b1; Q2 = 1'b1; end
        endcase
    end
end
    /*
    always @(*) begin
         case({S,R})
            2'b00:begin
            Q1 = Q1;   
            Q2 = Q2;
        end    
            2'b01:{Q1,Q2}=2'b01;
            2'b10:{Q1,Q2}=2'b10;
            2'b11:{Q1,Q2}=2'b11;
            endcase
       
    end
    */
    /*
    initial begin
        Q1=1'b0;
        Q2=1'b1;
    end
    */
    /*
    nor(Q1,  R,  Q2);
    nor(Q2, S,  Q1);
    */
endmodule
