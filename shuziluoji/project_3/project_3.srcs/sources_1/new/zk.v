`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/10 20:24:03
// Design Name: 
// Module Name: 1
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
 A,B,C,D,E,Y
    );
    input wire A,B,C,D,E;
    output wire Y;
    and U1(S1,A,B,C),    //A,b,c?????S1
            U2(S2,A,B,D),
            U3(S3,A,B,E),
            U4(S4,A,C,D),
            U5(S5,A,C,E),
            U6(S6,A,D,E),
            U7(S7,B,C,D),
            U8(S8,B,C,E),
            U9(S9,B,D,E),
            U10(S10,C,D,E);
    or U11(Y,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10);
    
endmodule
