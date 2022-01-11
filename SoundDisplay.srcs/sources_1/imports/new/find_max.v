`timescale 1ns / 1ps

module find_max(input sw, input CLOCK, input [15:0]mic_in, output reg [15:0]max = 0);
    reg [15:0]MAX = 0;
    reg [22:0]count = 0;
    always @ (posedge CLOCK) begin //100Mhz
        count <= (count == 4999999) ? 0: count + 1; //This basically makes this entire setup a 20khz clock
        if (mic_in > MAX) MAX <= mic_in;
        if (count == 0) begin
            max<= MAX; 
            MAX <=0;
        end 
        if (sw == 1) max <= mic_in; //Satisfy the condition where if you toggle a switch, the led will switch to mic_in rather than the peak intensity
    end
endmodule
