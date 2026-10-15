`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/08 15:58:20
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

reg PRE, CLR, CLK, D;
wire Q1, Q2;


always #10 CLK = ~CLK;


always #40 D = ~D;


initial begin
    
    PRE = 1'b1;  
    CLR = 1'b1;  
    CLK = 1'b0;
    D = 1'b0;
    #20;  

    
    PRE = 1'b0;  
    CLR = 1'b1;
    #20;  
    PRE = 1'b1;  
    #20;

    
    PRE = 1'b1;  
    CLR = 1'b0;
    #20;  
    CLR = 1'b1;  
    #40;

    
    #40;

   
    PRE = 1'b0;  
    CLR = 1'b0;
    #20;
    
    force Q1 = 1'b0;
    force Q2 = 1'b0;
    #20;
    
    release Q1;
    release Q2;
    PRE = 1'b1;
    CLR = 1'b1;
    #20;

    
    $finish;
end


zk utt(
    .PRE(PRE),
    .CLR(CLR),
    .CLK(CLK),
    .D(D),
    .Q1(Q1),
    .Q2(Q2)
);

endmodule
