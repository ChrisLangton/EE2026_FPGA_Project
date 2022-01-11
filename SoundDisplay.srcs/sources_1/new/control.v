`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2021 22:47:39
// Design Name: 
// Module Name: control
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


module control(
    input CLOCK,
    input [3:0]curr_task,
    input [15:0]rgbreg0,
    input [15:0]rgbreg1,
    input [15:0]rgbreg2,
    input [15:0]rgbreg3,
    input [15:0]rgbreg4,
    output reg [15:0]RGB
    );
    
    always @(posedge CLOCK) begin
            if (curr_task == 0)
                RGB <= rgbreg0; //lockscreen
            if (curr_task == 1)
                RGB <= rgbreg1; //menu
            if (curr_task == 2)
                RGB <= rgbreg2; //vol bar
            if (curr_task == 3)
                RGB <= rgbreg3; //car game
            if (curr_task == 4)
                RGB <= rgbreg4; //archery game
          
        end
endmodule
