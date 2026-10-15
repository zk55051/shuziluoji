`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/15 16:58:58
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
reg MR,Load,EN,CLK;
reg [3:0]D;
wire [3:0]Q;
wire CO;

always #15 CLK = ~CLK;


initial begin
    
    CLK  = 1'b0;
    MR   = 1'b1;
    Load = 1'b1;
    EN   = 1'b1;
    D    = 4'b0000;
    #20;

    
    MR = 1'b0;
    #20;
    MR = 1'b1;  
    #20;

   
    Load = 1'b0;
    D    = 4'b1010;
    #20;  
    Load = 1'b1;  
    #20;

    
    EN = 1'b0;
    #40; 
    EN = 1'b1;  
    #20;

   
    #180;  

   
    D = 4'b1111;
    Load = 1'b0;
    #20;  
    Load = 1'b1;
    #20;  

    $finish;
end

zk zk_utt(.MR(MR),.Load(Load),.EN(EN),.CLK(CLK),.D(D),.Q(Q),.CO(CO));

endmodule
