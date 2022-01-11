`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2021 11:41:38
// Design Name: 
// Module Name: single_pulse
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


module single_pulse(
    input SLOW_CLOCK,
    input btnC,
    output single_pulse
    );
    
    wire dff1_output;
    wire dff2_output;
    
    
    DFF dff1 (SLOW_CLOCK, btnC, dff1_output);
    DFF dff2 (SLOW_CLOCK, dff1_output, dff2_output);

    assign single_pulse = (dff1_output) & ~(dff2_output);
    //assign btnC = single_pulse;
    //assign led0 = single_pulse;
endmodule
