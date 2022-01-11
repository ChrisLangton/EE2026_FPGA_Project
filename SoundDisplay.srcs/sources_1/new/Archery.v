`timescale 1ns / 1ps

module Archery_Game(input [3:0]curr_task, input CLOCK, input up, input down, input right, input [15:0]sw, input [4:0]sound_level, input [4:0]freq_level, input [6:0]x, input [5:0]y, output reg [15:0]RGB, output reg [6:0]seg, output reg [3:0]an);
    //Colour Palette
    parameter [15:0]background      = 16'hF655;
    parameter [15:0]red             = 16'hEC8E;
    parameter [15:0]yellow          = 16'hFECC;
    parameter [15:0]green           = 16'hAE91;
    parameter [15:0]crosshair       = 16'h7568;
    //Board Colours
    parameter [15:0]white           = 16'hffff;    
    parameter [15:0]black           = 16'h0000;
    parameter [15:0]blue            = 16'h32B2;
    //Numbers
    reg [6:0]seg_0 = 7'b1111111; //This one is for an[0]
    reg [6:0]seg_1 = 7'b1111111; //This one is for an[1]
    reg [6:0]seg_2 = 7'b1111111; //This one is for an[2]
    reg [6:0]seg_3 = 7'b1111111; //This one is for an[3]
    reg [11:0]segment_0 = 0;
    reg [11:0]segment_1 = 0;
    reg [11:0]segment_2 = 0;
    reg [11:0]segment_3 = 0;
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
    //Main
    reg [1:0]sequence = 0; //For segment
    reg [3:0]variable1 = 1;
    reg [3:0]variable2 = 1;
    reg [23:0]score = 0;
    reg [2:0]gamemode = 0;
    reg [6:0]crosshair_x1 = 2;
    reg [5:0]crosshair_y1 = 31;
    reg [6:0]crosshair_x2 = 2;
    reg [5:0]crosshair_y2 = 31;
    reg [6:0]crosshair_x3 = 2;
    reg [5:0]crosshair_y3 = 31;
    reg [6:0]crosshair_x4 = 2;
    reg [5:0]crosshair_y4 = 2;

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //Clock creation//
    wire clk4hz, clk8hz, clk16hz, clk6p25m, clk381hz, clk3hz;
    new_clk clock1(CLOCK, 32'd131232, clk381hz); 
    new_clk clock2(CLOCK, 32'd12499999, clk4hz);
    new_clk clock3(CLOCK, 32'd6249999, clk8hz);
    new_clk clock4(CLOCK, 32'd3124999, clk16hz);
    new_clk clock5(CLOCK, 32'd7, clk6p25m);
    new_clk clock6(CLOCK, 32'd16666665, clk3hz);
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    always @ (sound_level, up, down) begin
        if (curr_task == 4) begin
        if (up == 1) begin
            variable1 = variable1 + 1;
            variable2 = variable2 + 1;
        end
        if (down == 1) begin
            variable1 = variable1 - 1;
            variable2 = variable2 - 1;
        end 
        if (gamemode == 1 && sound_level == 15) begin //Shot has been fired
            //Tallying up the score when a shot has been fired////////////////////////////////////////////////////////////
            if ((crosshair_y1 >= 5 && crosshair_y1 <= 57) && (crosshair_x1 >= 21 && crosshair_x1 <= 74)) score <= score + 1;
            if ((crosshair_y1 >= 10 && crosshair_y1 <= 53) && (crosshair_x1 >= 26 && crosshair_x1 <= 69)) score <= score + 2;
            if ((crosshair_y1 >= 17 && crosshair_y1 <= 46) && (crosshair_x1 >= 33 && crosshair_x1 <= 62)) score <= score + 3;
            if ((crosshair_y1 >= 23 && crosshair_y1 <= 40) && (crosshair_x1 >= 39 && crosshair_x1 <= 56)) score <= score + 4;
            if ((crosshair_y1 >= 28 && crosshair_y1 <= 35) && (crosshair_x1 >= 44 && crosshair_x1 <= 51)) score <= score + 5; 
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////            
        end
        if (gamemode == 2 && sound_level == 15) begin //Shot has been fired
            //Tallying up the score when a shot has been fired////////////////////////////////////////////////////////////
            if ((crosshair_y2 >= 5 && crosshair_y2 <= 57) && (crosshair_x2 >= 21 && crosshair_x2 <= 74)) score <= score + 1;
            if ((crosshair_y2 >= 10 && crosshair_y2 <= 53) && (crosshair_x2 >= 26 && crosshair_x2 <= 69)) score <= score + 2;
            if ((crosshair_y2 >= 17 && crosshair_y2 <= 46) && (crosshair_x2 >= 33 && crosshair_x2 <= 62)) score <= score + 3;
            if ((crosshair_y2 >= 23 && crosshair_y2 <= 40) && (crosshair_x2 >= 39 && crosshair_x2 <= 56)) score <= score + 4;
            if ((crosshair_y2 >= 28 && crosshair_y2 <= 35) && (crosshair_x2 >= 44 && crosshair_x2 <= 51)) score <= score + 5; 
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////            
        end
        if (gamemode == 3 && sound_level == 15) begin //Shot has been fired
            //Tallying up the score when a shot has been fired////////////////////////////////////////////////////////////
            if ((crosshair_y3 >= 5 && crosshair_y3 <= 57) && (crosshair_x3 >= 21 && crosshair_x3 <= 74)) score <= score + 1;
            if ((crosshair_y3 >= 10 && crosshair_y3 <= 53) && (crosshair_x3 >= 26 && crosshair_x3 <= 69)) score <= score + 2;
            if ((crosshair_y3 >= 17 && crosshair_y3 <= 46) && (crosshair_x3 >= 33 && crosshair_x3 <= 62)) score <= score + 3;
            if ((crosshair_y3 >= 23 && crosshair_y3 <= 40) && (crosshair_x3 >= 39 && crosshair_x3 <= 56)) score <= score + 4;
            if ((crosshair_y3 >= 28 && crosshair_y3 <= 35) && (crosshair_x3 >= 44 && crosshair_x3 <= 51)) score <= score + 5; 
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////            
        end
        if (gamemode == 4 && sound_level == 15) begin //Shot has been fired
            //Tallying up the score when a shot has been fired////////////////////////////////////////////////////////////
            if ((crosshair_y4 >= 5 && crosshair_y4 <= 57) && (crosshair_x4 >= 21 && crosshair_x4 <= 74)) score <= score + 1;
            if ((crosshair_y4 >= 10 && crosshair_y4 <= 53) && (crosshair_x4 >= 26 && crosshair_x4 <= 69)) score <= score + 2;
            if ((crosshair_y4 >= 17 && crosshair_y4 <= 46) && (crosshair_x4 >= 33 && crosshair_x4 <= 62)) score <= score + 3;
            if ((crosshair_y4 >= 23 && crosshair_y4 <= 40) && (crosshair_x4 >= 39 && crosshair_x4 <= 56)) score <= score + 4;
            if ((crosshair_y4 >= 28 && crosshair_y4 <= 35) && (crosshair_x4 >= 44 && crosshair_x4 <= 51)) score <= score + 5; 
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////            
        end
        if (sw[0] == 0 && sw[1] == 0 && sw[2] == 0 && sw[3] == 0) score <= 0;
        end     
    end
    
    always @ (sw) begin
        if (curr_task == 4) begin
        if (sw[0] == 0 && sw[1] == 0 && sw[2] == 0 && sw[3] == 0) begin
            gamemode = 0;
        end
        if (sw[0] == 1 && sw[1] == 0 && sw[2] == 0 && sw[3] == 0) begin
            gamemode = 1;
        end
        if (sw[0] == 0 && sw[1] == 1 && sw[2] == 0 && sw[3] == 0) begin
            gamemode = 2;
        end
        if (sw[0] == 0 && sw[1] == 0 && sw[2] == 1 && sw[3] == 0) begin
            gamemode = 3;
        end
        if (sw[0] == 0 && sw[1] == 0 && sw[2] == 0 && sw[3] == 1) begin
            gamemode = 4;
        end
        end
    end
    
    always @ (posedge clk4hz) begin
        crosshair_x1 <= (crosshair_x1 <= (94 - variable1) && gamemode == 1) ? crosshair_x1 + variable1 : 2;
        if (sw[15] == 1) crosshair_x1 <= (crosshair_x1 >= (2 + variable1) && gamemode == 1) ? crosshair_x1 - variable1 : 93; 
        
    end
    
    always @ (posedge clk8hz) begin
        crosshair_x2 <= (crosshair_x2 <= (94 - variable2) && gamemode == 2) ? crosshair_x2 + variable2 : 2;
        if (sw[15] ==1) crosshair_x2 <= (crosshair_x2 >= (2 + variable1) && gamemode == 2) ? crosshair_x2 - variable1 : 93; 
    end
    
    always @ (posedge clk16hz) begin
        crosshair_x3 <= (crosshair_x3 <= (94 - variable2) && gamemode == 3) ? crosshair_x3 + variable2 : 2;
        if (sw[15] ==1) crosshair_x3 <= (crosshair_x3 >= (2 + variable1) && gamemode == 3) ? crosshair_x3 - variable1 : 93;
        
        crosshair_x4 <= (crosshair_x4 <= (94 - freq_level) && gamemode == 4) ? crosshair_x4 + variable2 : 2;
        if (sw[15] ==1) crosshair_x4 <= (crosshair_x4 >= (2 + freq_level) && gamemode == 4) ? crosshair_x4 - variable1 : 93;
        
        crosshair_y4 <= (crosshair_y4 <= (63 - freq_level) && gamemode == 4) ? crosshair_y4 + freq_level : 2;
        if (sw[15] ==1) crosshair_y4 <= (crosshair_y4 >= (2 + freq_level) && gamemode == 4) ? crosshair_y4 - freq_level : 63;
    end
    
    always @ (posedge clk6p25m) begin
        RGB <= background;
        if ((y >= 5 && y <= 57) && (x >= 21 && x <= 74)) RGB <= white;
        if ((y >= 10 && y <= 53) && (x >= 26 && x <= 69)) RGB <= black;
        if ((y >= 17 && y <= 46) && (x >= 33 && x <= 62)) RGB <= blue;
        if ((y >= 23 && y <= 40) && (x >= 39 && x <= 56)) RGB <= red;
        if ((y >= 28 && y <= 35) && (x >= 44 && x <= 51)) RGB <= yellow;
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (gamemode == 1) begin //When switch 0 is toggled, gamemode 1 starts
            //Display the crosshair all the time
            if ((y == crosshair_y1 || y == crosshair_y1 - 1 || y == crosshair_y1 + 1) && (x == crosshair_x1 || x == crosshair_x1 + 1 || x == crosshair_x1 -1)) begin
                RGB <= crosshair;
            end
        end
        if (gamemode == 2) begin //When switch 1 is toggled, gamemode 2 starts
            //Display the crosshair all the time
            if ((y == crosshair_y2 || y == crosshair_y2 - 1 || y == crosshair_y2 + 1) && (x == crosshair_x2 || x == crosshair_x2 + 1 || x == crosshair_x2 -1)) begin
                RGB <= crosshair;
            end
        end
        if (gamemode == 3) begin //When switch 1 is toggled, gamemode 2 starts
            //Display the crosshair all the time
            if ((y == crosshair_y3 || y == crosshair_y3 - 1 || y == crosshair_y3 + 1) && (x == crosshair_x3 || x == crosshair_x3 + 1 || x == crosshair_x3 -1)) begin
                RGB <= crosshair;
            end
        end
        if (gamemode == 4) begin
            if ((y == crosshair_y4 || y == crosshair_y4 - 1 || y == crosshair_y4 + 1) && (x == crosshair_x4 || x == crosshair_x4 + 1 || x == crosshair_x4 -1)) begin
                RGB <= crosshair;
            end
        end    
    end
    
    always @ (score) begin
        segment_3 <= (score / 1000); //Gets me the 1000s digit
        segment_2 <= ((score % 1000) / 100); //Gets me the 100s digit
        segment_1 <= ((score % 100) / 10); //Get me the 10s digit
        segment_0 <= (score % 10); //Get me the 1s digit
        
        case(segment_0) 
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
        
        case(segment_1)
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
        
        case(segment_2)
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
        
        case(segment_3)
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
    
    always @ (posedge clk381hz) begin
       sequence <= (sequence == 3) ? 0 : sequence + 1;
       case(sequence) //Each number in the sequence represent the anode that is to be turned on
       0: begin
       an <= 4'b1110;
       seg <= seg_0;
       end
       1: begin
       an <= 4'b1101;
       seg <= seg_1;
       end
       2: begin
       an <= 4'b1011; 
       seg <= seg_2;
       end
       3: begin
       an <= 4'b0111;
       seg <= seg_3;
       end
       endcase
    end  
endmodule
