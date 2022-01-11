`timescale 1ns / 1ps

module sound_freq(input [3:0]curr_task, input clk381hz, input CLOCK, input [15:0] mic_in, input [31:0]M, output [3:0]an, output [6:0]seg, output reg [15:0]freq_sound = 0);
    reg [3:0]AN = 4'b1111;
    reg [6:0]SEG = 7'b1111111;
    reg [6:0]seg_0 = 7'b1111111; //This one is for an[0]
    reg [6:0]seg_1 = 7'b1111111; //This one is for an[1]
    reg [6:0]seg_2 = 7'b1111111; //This one is for an[2]
    reg [6:0]seg_3 = 7'b1111111; //This one is for an[3]
    reg [6:0]num0 = 7'b1000000;
    reg [6:0]num1 = 7'b1111001; 
    reg [6:0]num2 = 7'b0100100; 
    reg [6:0]num3 = 7'b0110000; 
    reg [6:0]num4 = 7'b0011001; 
    reg [6:0]num5 = 7'b0010010; 
    reg [6:0]num6 = 7'b0000011; 
    reg [6:0]num7 = 7'b1111000; 
    reg [6:0]num8 = 7'b0000000; 
    reg [6:0]num9 = 7'b0011000; 
    reg [31:0]counter1 = 0;
    reg period = 0;
    reg [1:0]sequence = 0;
    reg [12:0]counter2 = 0;
    reg [31:0]frequency = 0;
    reg [3:0]frequency_0 = 0;
    reg [3:0]frequency_1 = 0;
    reg [3:0]frequency_2 = 0;
    reg [3:0]frequency_3 = 0;
    reg reset = 0;                                          //Reset Frequency 5Hz
    
    
    always @ (posedge period, posedge reset) begin
        if (reset == 1)
            counter2 <= 0;
        else 
            counter2 <= counter2 + 1;
    end
    
    always @ (posedge CLOCK) begin
        reset = 0;
        if(mic_in > 2100) period <= 1;                      //Prominent Sound is Produced
        else period <= 0;               
        
        counter1 <= (counter1 == M) ? 0 : counter1 +1;             
        
        if(counter1 == M)                                   
        begin
            frequency = counter2;                       //Counter in 0.2s, thus frequency mutliplied by 5 to get frequency in 1 second
            reset = 1;
            
            if      (frequency < 100) freq_sound = 0;
            else if (frequency < 200) freq_sound = 16'd1;
            else if (frequency < 300) freq_sound = 16'd2;
            else if (frequency < 400) freq_sound = 16'd3;
            else if (frequency < 500) freq_sound = 16'd4;
            else if (frequency < 600) freq_sound = 16'd5;
            else if (frequency < 700) freq_sound = 16'd6;
            else if (frequency < 800) freq_sound = 16'd7;
            else if (frequency < 900) freq_sound = 16'd8;
            else if (frequency < 1000) freq_sound = 16'd9;
            else if (frequency < 1100) freq_sound = 16'd10;
            else if (frequency < 1200) freq_sound = 16'd11;
            else if (frequency < 1300) freq_sound = 16'd12;
            else if (frequency < 1400) freq_sound = 16'd13;
            else if (frequency < 1500) freq_sound = 16'd14;
            else if (frequency < 1600) freq_sound = 16'd15;
            else                       freq_sound = 16'd15; 
            
            frequency_3 <= (frequency / 1000); //Gets me the 1000s digit
            frequency_2 <= ((frequency % 1000) / 100); //Gets me the 100s digit
            frequency_1 <= ((frequency % 100) / 10); //Get me the 10s digit
            frequency_0 <= (frequency % 10); //Get me the 1s digit
        end
    end
    
    always @ (frequency) begin //Whenever frequency changes, values displayed in segment also changes
        case(frequency_0) //extract the first digit of the frequency
        0: seg_0 <= num0;
        1: seg_0 <= num1;
        2: seg_0 <= num2;
        3: seg_0 <= num3;
        4: seg_0 <= num4;
        5: seg_0 <= num5;
        6: seg_0 <= num6;
        7: seg_0 <= num7;
        8: seg_0 <= num8;
        9: seg_0 <= num9;
        endcase
        
        case(frequency_1)
        0: seg_1 <= num0;
        1: seg_1 <= num1;
        2: seg_1 <= num2;
        3: seg_1 <= num3;
        4: seg_1 <= num4;
        5: seg_1 <= num5;
        6: seg_1 <= num6;
        7: seg_1 <= num7;
        8: seg_1 <= num8;
        9: seg_1 <= num9;
        endcase
        
        case(frequency_2)
        0: seg_2 <= num0;
        1: seg_2 <= num1;
        2: seg_2 <= num2;
        3: seg_2 <= num3;
        4: seg_2 <= num4;
        5: seg_2 <= num5;
        6: seg_2 <= num6;
        7: seg_2 <= num7;
        8: seg_2 <= num8;
        9: seg_2 <= num9;
        endcase
        
        case(frequency_3)
        0: seg_3 <= num0;
        1: seg_3 <= num1;
        2: seg_3 <= num2;
        3: seg_3 <= num3;
        4: seg_3 <= num4;
        5: seg_3 <= num5;
        6: seg_3 <= num6;
        7: seg_3 <= num7;
        8: seg_3 <= num8;
        9: seg_3 <= num9;
        endcase
    end
    
    always @ (posedge CLOCK) begin
       sequence <= (sequence == 3) ? 0 : sequence + 1;
       case(sequence) //Each number in the sequence represent the anode that is to be turned on
       0: begin
       AN <= 4'b1110;
       SEG <= seg_0;
       end
       1: begin
       AN <= 4'b1101;
       SEG <= seg_1;
       end
       2: begin
       AN <= 4'b1011; 
       SEG <= seg_2;
       end
       3: begin
       AN <= 4'b0111;
       SEG <= seg_3;
       end
       endcase
    end
    
    assign an = AN;
    assign seg = SEG;
endmodule
