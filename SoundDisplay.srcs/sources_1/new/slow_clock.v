`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2021 11:48:01
// Design Name: 
// Module Name: slow_clock
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


module slow_clock(
    input CLOCK,
    output SLOW_CLOCK
    );
    
    reg [24:0]COUNT = 25'b0;
    
    always @ (posedge CLOCK) begin
        COUNT <= COUNT + 1;
    end
    
    assign SLOW_CLOCK = COUNT[17];
    
endmodule
