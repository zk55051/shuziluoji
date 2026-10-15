`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/02 21:53:34
// Design Name: 
// Module Name: to_display
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


module to_display();

reg [31:0]sw;
wire [31:0]led;

initial begin //?????????????
//?????
sw=32'b101; //32¦Ë b-???????????0
#100 //???100?????¦Ë
sw=32'b110;
#100
sw=32'h711748; //32¦Ë h-???????

end

project_2 display_utt(
 .sw(sw),.led(led)
);

endmodule
