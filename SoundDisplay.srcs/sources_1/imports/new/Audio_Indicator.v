`timescale 1ns / 1ps

module Audio_Indicator(input sw, input [3:0]curr_task, input CLOCK, input [15:0]max, output reg[15:0]led, output reg[3:0]an, output reg[6:0]seg, output reg[3:0] vol); //This is the main module for the Real-Time Audio Indicator Feature
    reg [15:0]LED = 0;
    reg [3:0]AN = 4'b1111;
    reg [6:0]SEG = 7'b1111111;
    reg [6:0]alpha = 0;
    reg [6:0]alphaL = 7'b1000111; //Use for Displaying the Alphabets 1000111
    reg [6:0]alphaM = 7'b1101010; 
    reg [6:0]alphaH = 7'b0001001; 
    reg [1:0]sequence = 0; // Use for alternating through anodes
    wire clk381hz; //Clock for displaying segment 
    new_clk(CLOCK, 32'd131232, clk381hz); 
    reg [6:0]seg_0 = 7'b1111111; //This one is for an[0]
    reg [6:0]seg_1 = 7'b1111111; //This one is for an[1]
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
     
    always @ (posedge CLOCK) begin //Requires 15 discrete levels 6 Lows, 6 Mediums & 5 Highs
        if (max < 2170) begin 
            LED <= 16'd0;
            vol <= 0;
            alpha <= alphaL;
        end
        else if (max < 2290) begin
            LED <= 16'd1;
            vol <= 1;
            alpha <= alphaL;
        end
        else if (max < 2410) begin
            LED <= 16'd3;
            vol <= 2;
            alpha <= alphaL;
        end
        else if (max < 2530) begin
            LED <= 16'd7;
            vol <= 3;
            alpha <= alphaL;
        end
        else if (max < 2650) begin
            LED <= 16'd15;
            vol <= 4;
            alpha <= alphaL;
        end
        else if (max < 2770) begin
            LED <= 16'd31;
            vol <= 5;
            alpha <= alphaL;    
        end
        else if (max < 2890) begin
            LED <= 16'd63;
            vol <= 6;
            alpha <= alphaM;
        end
        else if (max < 3010) begin
            LED <= 16'd127;
            vol <= 7;
            alpha <= alphaM;
        end
        else if (max < 3130) begin
            LED <= 16'd255;
            vol <= 8;
            alpha <= alphaM;
        end
        else if (max < 3250) begin
            LED <= 16'd511;
            vol <= 9;
            alpha <= alphaM;
        end
        else if (max < 3370) begin
            LED <= 16'd1023;
            vol <= 10;
            alpha <= alphaM;
        end
        else if (max < 3370) begin
            LED <= 16'd2047;
            vol <= 11;
            alpha <= alphaM;
        end  
        else if (max < 3490) begin
            LED <= 16'd4095;
            vol <= 12;
            alpha <= alphaM;
        end
        else if (max < 3610) begin
            LED <= 16'd8191;
            vol <= 13;
            alpha <= alphaH;
        end
        else if (max < 3730) begin
            LED <= 16'd16383;
            vol <= 14;
            alpha <= alphaH;
        end
        else if (max < 3850) begin
            LED <= 16'd32767;
            vol <= 15;
            alpha <= alphaH;
        end
        else begin //LEDs are all on
            LED <= 16'd65535;
            vol <= 15;
            alpha <= alphaH;
        end
    end
    
    always @ (*) begin //Whenever vol changes, values displayed in segment also changes
      if (curr_task == 2) begin
        seg_1 <= (vol >= 10) ? num1 : num0;
        
        case(vol)
        0, 10: seg_0 <= num0;
        1, 11: seg_0 <= num1;
        2, 12: seg_0 <= num2;
        3, 13: seg_0 <= num3;
        4, 14: seg_0 <= num4;
        5, 15: seg_0 <= num5;
        6    : seg_0 <= num6;
        7    : seg_0 <= num7;
        8    : seg_0 <= num8;
        9    : seg_0 <= num9;
        endcase
      end
   end
   
   always @ (posedge clk381hz) begin
    if (curr_task == 2) begin
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
       SEG <= 7'b1111111;
       end
       3: begin
       AN <= 4'b0111;
       SEG <= (sw == 1) ? alpha : 7'b1111111; //Unless switch is turned on, an[3] is off
       end
       endcase
     end
   end
   
   
  always @ (posedge CLOCK) begin
     led <= LED;
     if (curr_task == 2) begin
         an <= AN;
         seg <= SEG;
     end
  end
endmodule
