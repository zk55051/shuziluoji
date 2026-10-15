`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/17 21:31:41
// Design Name: 
// Module Name: add
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


module add(
   a,b,cin,s,cout
    );
    input wire a,b,cin;
    output wire s,cout;
    
    wire temp1,temp2,temp3;
    
    xor U1(temp1, a, b);      
    xor U2(s, temp1, cin); 

    and U3(temp3, a, b);         
    and U4(temp2, temp1, cin);         
or  U5(cout, temp3,temp2); 

endmodule
