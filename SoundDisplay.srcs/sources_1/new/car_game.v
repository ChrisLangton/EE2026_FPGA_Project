`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2021 12:42:10
// Design Name: 
// Module Name: car_game
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


module car_game(
    input CLOCK_6_25MHZ,
    input CLOCK_30HZ,
    input CLOCK,
    input [3:0]curr_task,
    input sp_btnL,
    input sp_btnR,
    input sp_btnU,
    input sp_btnD, 
    input [12:0]x,
    input [12:0]y,
    output reg [15:0]RGB,
    output reg endgame = 0, //set to 1 when last_button == btnL && block_left
    output reg [3:0]anreg = 4'b1111,
    output reg [6:0]segreg = 7'b1111111,
    input [3:0]sound_level
    );
    
    reg [3:0]wave_done = 4'd0; // wave counter
    reg [16:0]count = 17'd1;
    reg [15:0]count2 = 16'd1; // overflow at 11Hz
    reg [14:0]count3 = 15'd1;
    reg [5:0]down = 6'd0; // move objects down
    reg [35:0]counter = 36'b0;
    
    reg [7:0]L = 8'd0; // subtract this
    reg [7:0]R = 8'd0; // add this
    reg [7:0]L1 = 8'd0; // brick 1
    reg [7:0]R1 = 8'd0;
    reg [7:0]L2 = 8'd0; // brick 2
    reg [7:0]R2 = 8'd0;
    reg [7:0]L3 = 8'd0; // coin
    reg [7:0]R3 = 8'd0;
    
    //booleans for position
    reg car_centre = 0;
    reg car_left = 0;
    reg car_right = 0;
    reg [1:0]block1_pos = 0; // 1 left, 2 centre, 3 right, 0 absent
    reg [1:0]block2_pos = 0; 
    reg [1:0]coin_pos = 0;
    
    
    //COLOURS
    reg [15:0]beige = 16'hEC45;
    reg [15:0]black = 16'b00000_000000_00000;
    reg [15:0]white = 16'b11111_111111_11111;
    reg [15:0]cyan = 16'b00000_111111_11111;
    reg [15:0]light_gray = 16'b11001_110100_11001;
    reg [15:0]dark_gray = 16'b01011_011010_01011;
    reg [15:0]yellow = 16'b11111_111111_00000;
    reg [15:0]red = 16'b11111_00000_00000;
    reg [15:0]brown = 16'b10001_010001_00010;
    reg [15:0]gold = 16'b11111_110100_00000;
    
    reg [4:0]score_check = 5'b0;
    reg [6:0]score = 7'b0; //increment when wave_done && coin_in_wave
    reg [1:0]last_button = 2'd1; // car starts in the center
    reg flag = 0;
    reg flag1 = 0;
    
    
    always @ (posedge CLOCK) begin
        counter <= counter + 1;
        if (counter%2 == 0)
            counter <= counter + 3;
        if (counter%3 == 0)
            counter <= counter + 5;
        if (counter%5 == 0)
            counter <= counter + 7;
        if (counter%7 == 0)
            counter <= counter + 4;
        if (counter%11 == 0)
            counter <= counter*2 - 9;
            
    end
    
    
    always @ (posedge CLOCK_6_25MHZ) begin
     score_check <= score_check + 1;
     if (flag1 == 1 && sp_btnD == 1) begin
                flag1 <= 0;
                down <= 0;
     end
     if (endgame == 1 && curr_task == 1)
        score <= 0;
     if (curr_task == 3) begin
            count <= count + 1;
            count2 <= count2 + 1;
            count3 <= count3 + 1;
        if (sound_level <= 14 && score < 10) begin
            down <= (count == 0) ? down + 1 : down; //obstacles move down pixels only when count overflows (11Hz)
            flag <= 0;
        end
        if (sound_level <= 14 && score >= 10) begin
            down <= (count == 0) ? down + 1 : down; //obstacles move down pixels only when count overflows (11Hz)
            flag <= 0;
        end
        if (sound_level == 15)
            down <= (count2 == 0) ? down + 1 : down;
        if (down == 38) begin
            down <= 0; // reset down when obstacles reach bottom
            wave_done <= counter%10;
        end
            
        if (sp_btnL == 1)
            last_button <= 2'd2;
        else if (sp_btnU == 1)
            last_button <= 2'd1;
        else if (sp_btnR == 1)
            last_button <= 2'd3;
        
        if (last_button == 1) begin
            L <= 0; // no shift
            R <= 0;
            car_centre <= 1;
            car_left <= 0;
            car_right <= 0;
        end
        else if (last_button == 2) begin
            L <= 28; //left shift
            R <= 0;
            car_left <= 1;
            car_centre <= 0;
            car_right <= 0;
        end
        else if (last_button == 3) begin
            R <= 28; //right shift
            L <= 0;
            car_right <= 1;
            car_left <= 0;
            car_centre <= 0;
        end
        
        case(wave_done)
            0: begin
                L1 <= 28; // block1 left
                R1 <= 0;
                L2 <= 0;
                R2 <= 28; // block2 right
                L3 <= 0;
                R3 <= 0; // coin centre
                block1_pos <= 1;
                block2_pos <= 3;
                coin_pos <= 2;
            end
            1: begin
                L1 <= 0; // block1 centre
                R1 <= 0;
                L2 <= 0;
                R2 <= 28; // block2 right
                L3 <= 28;
                R3 <= 0; // coin left
                block1_pos <= 2;
                block2_pos <= 3;
                coin_pos <= 1;                
            end            
            2: begin
                L1 <= 0; // block1 centre
                R1 <= 0;
                L2 <= 28;
                R2 <= 0; // block2 left
                L3 <= 0;
                R3 <= 28; // coin right
                block1_pos <= 2;
                block2_pos <= 1;
                coin_pos <= 3;           
            end
            3: begin
                L1 <= 28; // block1 left
                R1 <= 0;
                L2 <= 0;
                R2 <= 28; // block2 right
                L3 <= 0;
                R3 <= 100; // no coin
                block1_pos <= 1;
                block2_pos <= 3;
                coin_pos <= 0;
            end
            4: begin
                L1 <= 28; // block1 left
                R1 <= 0;
                L2 <= 0;
                R2 <= 0; // block2 centre
                L3 <= 0;
                R3 <= 100; // no coin
                block1_pos <= 1;
                block2_pos <= 2;
                coin_pos <= 0;                
            end
            5: begin
                L1 <= 0; // block1 centre
                R1 <= 0;
                L2 <= 0;
                R2 <= 28; // block2 right
                L3 <= 0;
                R3 <= 100; // no coin
                block1_pos <= 2;
                block2_pos <= 3;
                coin_pos <= 0;
            end
            6: begin
                L1 <= 28; // block1 left
                R1 <= 0;
                L2 <= 0;
                R2 <= 100; // no block2
                L3 <= 0;
                R3 <= 100; // no coin
                block1_pos <= 1;
                block2_pos <= 0;
                coin_pos <= 0;
            end
            7: begin
                L1 <= 0; // no block1
                R1 <= 100;
                L2 <= 0;
                R2 <= 28; // block2 right
                L3 <= 0;
                R3 <= 100; // no coin
                block1_pos <= 0;
                block2_pos <= 3;
                coin_pos <= 0;
            end
            8: begin
                L1 <= 0; // no block1
                R1 <= 100;
                L2 <= 0;
                R2 <= 0; // block2 centre
                L3 <= 0;
                R3 <= 100; // no coin
                block1_pos <= 0;
                block2_pos <= 2;
                coin_pos <= 0;
            end
            9: begin
                L1 <= 0; // block1 centre
                R1 <= 0;
                L2 <= 0;
                R2 <= 100; // no block2
                L3 <= 28;
                R3 <= 0; // coin left
                block1_pos <= 2;
                block2_pos <= 0;
                coin_pos <= 1;
            end
            10: begin
                L1 <= 0; // block1 centre
                R1 <= 0;
                L2 <= 0;
                R2 <= 100; // no block2
                L3 <= 0;
                R3 <= 28; // coin right
                block1_pos <= 2;
                block2_pos <= 0;
                coin_pos <= 3;
            end     
        endcase
        
        
        if (down == 37 && ((car_left == 1 && (block1_pos == 1 || block2_pos == 1)) || (car_centre == 1 && (block1_pos == 2 || block2_pos == 2)) || (car_right == 1 && (block1_pos == 3 || block2_pos == 3)))) begin
            endgame <= 1;
            flag1 <= 1;
            down <= 0;
        end
        else if (flag1 <= 0)
            endgame <= 0;
        
        if (down == 37 && sound_level == 15 && flag == 0 && ((car_left == 1 && coin_pos == 1) || (car_centre == 1 && coin_pos == 2) || (car_right == 1 && coin_pos == 3))) begin
            score <= score + 1;
            flag <= 1;
        end
        
        case(score_check)
                0:begin
                    if(score == 0 || score == 10 || score == 20 || score == 30 || score == 40 || score == 50 || score == 60 || score == 70 || score == 80 || score == 90) begin
                        anreg <= 4'b1110;
                        segreg <= 7'b1000000; // 0
                    end
                end
                1:begin
                    if(score == 1 || score == 11 || score == 21 || score == 31 || score == 41 || score == 51 || score == 61 || score == 71 || score == 81 || score == 91) begin
                        anreg <= 4'b1110;
                        segreg <= 7'b1111001; // 1
                    end
                end
                2:begin
                    if(score == 2 || score == 12 || score == 22 || score == 32 || score == 42 || score == 52 || score == 62 || score == 72 || score == 82 || score == 92) begin
                        anreg <= 4'b1110;
                        segreg <= 7'b0100100; // 2
                    end
                end
                3:begin
                    if(score == 3 || score == 13 || score == 23 || score == 33 || score == 43 || score == 53 || score == 63 || score == 73 || score == 83 || score == 93) begin
                        anreg <= 4'b1110;
                        segreg <= 7'b0110000; // 3
                    end
                end
                4:begin
                    if(score == 4 || score == 14 || score == 24 || score == 34 || score == 44 || score == 54 || score == 64 || score == 74 || score == 84 || score == 94) begin
                        anreg <= 4'b1110;
                        segreg <= 7'b0011001; // 4
                    end
                end
                5:begin
                    if(score == 5 || score == 15 || score == 25 || score == 35 || score == 45 || score == 55 || score == 65 || score == 75 || score == 85 || score == 95) begin
                        anreg <= 4'b1110;
                        segreg <= 7'b0010010; // 5
                    end
                end
                6:begin
                    if(score == 6 || score == 16 || score == 26 || score == 36 || score == 46 || score == 56 || score == 66 || score == 76 || score == 86 || score == 96) begin
                        anreg <= 4'b1110;
                        segreg <= 7'b0000010; // 6
                    end
                end
                7:begin
                    if(score == 7 || score == 17 || score == 27 || score == 37 || score == 47 || score == 57 || score == 67 || score == 77 || score == 87 || score == 97) begin
                        anreg <= 4'b1110;
                        segreg <= 7'b1111000; // 7
                    end
                end
                8:begin
                    if(score == 8 || score == 18 || score == 28 || score == 38 || score == 48 || score == 58 || score == 68 || score == 78 || score == 88 || score == 98) begin
                        anreg <= 4'b1110;
                        segreg <= 7'b0000000; // 8
                    end
                end
                9:begin
                    if(score == 9 || score == 19 || score == 29 || score == 39 || score == 49 || score == 59 || score == 69 || score == 79 || score == 89 || score == 99) begin
                        anreg <= 4'b1110;
                        segreg <= 7'b0010000; // 9
                    end
                end
                10:begin
                    if(score >= 10 && score <= 19) begin
                        anreg <= 4'b1101;
                        segreg <= 7'b1111001; // 1
                    end
                end
                11:begin
                    if(score >= 20 && score <= 29) begin
                        anreg <= 4'b1101;
                        segreg <= 7'b0100100; // 2
                    end
                end
                12:begin
                    if(score >= 30 && score <= 39) begin
                        anreg <= 4'b1101;
                        segreg <= 7'b0110000; // 3
                    end
                end
                13:begin
                    if (score >= 40 && score <= 49) begin
                        anreg <= 4'b1101;
                        segreg <= 7'b0011001; // 4
                    end
                end
                14:begin
                    if (score >= 50 && score <= 59) begin
                        anreg <= 4'b1101;
                        segreg <= 7'b0010010; // 5
                    end
                end
                15:begin
                    if (score >= 60 && score <= 69) begin
                        anreg <= 4'b1101;
                        segreg <= 7'b0000010; // 6
                    end
                end
                16:begin
                    if (score >= 70 && score <= 79) begin
                        anreg <= 4'b1101;
                        segreg <= 7'b1111000; // 7
                    end
                end
                17:begin
                    if (score >= 80 && score <= 89) begin
                        anreg <= 4'b1101;
                        segreg <= 7'b0000000; // 8
                    end
                end
                18:begin
                    if (score >= 90 && score <= 99) begin
                        anreg <= 4'b1101;
                        segreg <= 7'b0010000; // 9
                    end
                end
                19: score_check <= 0;                       
            endcase
        
        if (endgame == 0) begin
        
            // DRAW CAR
            if (((x == 44+R-L || x == 52+R-L) && ((y >= 52 && y <= 54) || (y >= 60 && y <= 62))) || ((y == 63 || y == 61) && x >= 46+R-L && x <= 50+R-L)) 
                RGB <= black; // wheels and spoiler
            else if (((x == 45+R-L || x == 51+R-L) && ((y >= 52 && y <= 54) || (y >= 60 && y <= 62))) || ((x == 46+R-L || x == 50+R-L) && ((y >= 51 && y <= 53) || (y >= 59 && y <= 61))) || (x == 44+R-L && y == 55) || (x == 52+R-L && y == 55) || (x == 48+R-L && y >= 50 && y <= 53))
                RGB <= cyan; // front body
            else if ((y == 54 && x >= 46+R-L && x <= 50+R-L) || (y == 55 && x >= 45+R-L && x <= 51+R-L) || ((x == 45+R-L || x == 51+R-L) && y >= 57 && y <= 59))
                RGB <= dark_gray; // window visors
            else if (((x == 45+R-L || x == 51+R-L) && y == 51) || ((x == 46+R-L || x == 50+R-L) && y == 50))
                RGB <= yellow; // headlights
            else if (((x >= 45+R-L && x <= 46+R-L) && (y == 56 || y == 60 || y == 63)) || ((x == 46+R-L || x == 50+R-L) && (y >= 57 && y <= 59)) || ((x == 45+R-L || x == 51+R-L) && y == 61) || (x >= 50+R-L && x <= 51+R-L && y == 56) || (x == 48+R-L && ((y >= 56 && y <= 60) || y == 62)))
                RGB <= cyan; // back body
            else if ((x == 47+R-L || x == 49+R-L) && ((y >= 50 && y <= 53) || (y >= 56 && y <= 60) || (y == 62)))
                RGB <= light_gray; // racing stripes
            else if (y == 63 && (x == 45+R-L || x == 51+R-L))
                RGB <= red; // tail lights
                
            //DRAW ROAD LINES
            
            else if ((x >= 4 && x <= 6) || (x >= 89 && x <= 91))
                RGB <= black; // road borders
            else if ((x == 34 || x == 62) && ((y >= 9 && y <= 17) || (y >= 26 && y <= 34) || (y >= 43 && y <= 51)))
                RGB <= black; // lane lines
                
            // DRAW BRICK_1
            else if ((x >= 42+R1-L1 && x <= 54+R1-L1 && y >= 0+down && y <= 14+down) && !(y == 3+down || y == 7+down || y == 11+down || (x == 48+R1-L1 && ((y >= 0+down && y <= 2+down) || (y >= 8+down && y <= 10+down)))  || ((x == 45+R1-L1 || x == 51+R1-L1) && ((y >= 4+down && y <= 6+down) || (y >= 12+down && y <= 14+down)))))
                RGB <= brown;
            else if ((x >= 42+R1-L1 && x <= 54+R1-L1 && y >= 0+down && y <= 14+down) && (y == 3+down || y == 7+down || y == 11+down || (x == 48+R1-L1 && ((y >= 0+down && y <= 2+down) || (y >= 8+down && y <= 10+down)))  || ((x == 45+R1-L1 || x == 51+R1-L1) && ((y >= 4+down && y <= 6+down) || (y >= 12+down && y <= 14+down)))))
                RGB <= black;
                
            // DRAW BRICK_2
            else if ((x >= 42+R2-L2 && x <= 54+R2-L2 && y >= 0+down && y <= 14+down) && !(y == 3+down || y == 7+down || y == 11+down || (x == 48+R2-L2 && ((y >= 0+down && y <= 2+down) || (y >= 8+down && y <= 10+down)))  || ((x == 45+R2-L2 || x == 51+R2-L2) && ((y >= 4+down && y <= 6+down) || (y >= 12+down && y <= 14+down)))))
               RGB <= brown; //brick base
            else if ((x >= 42+R2-L2 && x <= 54+R2-L2 && y >= 0+down && y <= 14+down) && (y == 3+down || y == 7+down || y == 11+down || (x == 48+R2-L2 && ((y >= 0+down && y <= 2+down) || (y >= 8+down && y <= 10+down)))  || ((x == 45+R2-L2 || x == 51+R2-L2) && ((y >= 4+down && y <= 6+down) || (y >= 12+down && y <= 14+down)))))
               RGB <= black; //cracks
            
            
            // DRAW COIN
            else if (((x >= 46+R3-L3 && x <= 50+R3-L3) && (y == 0+down || y == 12+down)) || ((x == 42+R3-L3 || x == 54+R3-L3) && (y >= 4+down && y <= 8+down)) || ((x == 43+R3-L3 || x == 53+R3-L3) && ((y >= 2+down && y <= 3+down) || (y >= 9+down && y <= 10+down))) || ((y == 1+down || y == 11+down) && ((x >= 44+R3-L3 && x <= 45+R3-L3) || (x >= 51+R3-L3 && x <= 52+R3-L3))))
                RGB <= black; // coin outline
            else if ((x == 43+R3-L3 && (y >= 4+down && y <= 8+down)) || (x == 44+R3-L3 && (y >= 3+down && y <= 10+down)) || (x == 45+R3-L3 && y >= 4+down && y <= 10+down) || (x == 46+R3-L3 && y >= 5+down && y <= 11+down) || (x == 47+R3-L3 && y >= 6+down && y <= 11+down) || (x == 48+R3-L3 && y >= 7+down && y <= 11+down) || (x == 49+R3-L3 && y >= 8+down && y <= 11+down) || (x == 50+R3-L3 && y >= 9+down && y <= 11+down) || (x == 51+R3-L3 && y == 10+down))
                RGB <= gold; // coin half
            else if ((y == 2+down && x >= 44+R3-L3 && x <= 46+R3-L3) || (y == 3+down && x >= 45+R3-L3 && x <= 47+R3-L3) || (y == 4+down && x >= 46+R3-L3 && x <= 48+R3-L3) || (y == 5+down && x >= 47+R3-L3 && x <= 49+R3-L3) || (y == 6+down && x >= 48+R3-L3 && x <= 50+R3-L3) || (y == 7+down && x >= 49+R3-L3 && x <= 51+R3-L3) || (y == 8+down && x >= 50+R3-L3 && x <= 52+R3-L3) || (y == 9+down && x >= 51+R3-L3 && x <= 52+R3-L3) || (y == 10+down && x == 52+R3-L3))
                RGB <= white; // coin diagonal reflection
            else if ((y == 1+down && x >= 46+R3-L3 && x <= 50+R3-L3 && x != 48+R3-L3) || (y == 2+down && x >= 47+R3-L3 && x <= 52+R3-L3 && x != 49+R3-L3) || (y == 3+down && x >= 48+R3-L3 && x <= 52+R3-L3 && x != 50+R3-L3) || (y == 4+down && x >= 49+R3-L3 && x <= 53+R3-L3 && x != 51+R3-L3) || (y == 5+down && x >= 50+R3-L3 && x <= 53+R3-L3 && x != 52+R3-L3) || (y == 6+down && x >= 51+R3-L3 && x <= 52+R3-L3) || (y == 7+down && x >= 52+R3-L3 && x <= 53+R3-L3) || (y == 8+down && x == 53+R3-L3))
                RGB <= gold; //coin half
            else if ((y == 1+down && x == 48+R3-L3) || (y == 2+down && x == 49+R3-L3) || (y == 3+down && x == 50+R3-L3) || (y == 4+down && x == 51+R3-L3) || (y == 5+down && x == 52+R3-L3) || (y == 6+down && x == 53+R3-L3))
                RGB <= white; //coin diag reflection
            else
                RGB <= beige;
                
                   
        end
        if (endgame == 1) begin
           if (x >= 22 && x <= 23 && y >= 24 && y <= 36)
               RGB <= 16'b11111_111111_11111; // white D first vertical
           else if ((x >= 24 && x <= 28) && ((y >= 24 && y <= 25) || (y >= 35 && y <= 36)))
               RGB <= 16'b11111_111111_11111; // white D horizontals
           else if ((x == 28 && (y == 26 || y == 34)) || (x == 29 && (y == 25 || y == 35)))
               RGB <= 16'b11111_111111_11111; // white D diagonals 
           else if (x >= 29 && x <= 30 && y >= 26 && y <= 34)
               RGB <= 16'b11111_111111_11111; // white D second vertical
           else if (x >= 37 && x <= 38 && y >= 24 && y <= 36)
               RGB <= 16'b11111_111111_11111; // white E vertical
           else if ((x >= 39 && x <= 44) && ((y >= 24 && y <= 25) || (y >= 29 && y <= 30) || (y >= 35 && y <= 36)))
               RGB <= 16'b11111_111111_11111; // white E horizontals
           else if ((y >= 24 && y <= 36) && ((x >= 51 && x <= 52) || (x >= 57 && x <= 58)))
               RGB <= 16'b11111_111111_11111; // white A verticals
           else if ((x >= 53 && x <= 56) && ((y >= 30 && y <= 31) || (y >= 24 && y <= 25)))
               RGB <= 16'b11111_111111_11111; // white A horizontals
           else if (x >= 65 && x <= 66 && y >= 24 && y <= 36)
               RGB <= 16'b11111_111111_11111; // white D first vertical
           else if ((x >= 67 && x <= 71) && ((y >= 24 && y <= 25) || (y >= 35 && y <= 36)))
               RGB <= 16'b11111_111111_11111; // white D horizontals
           else if ((x == 71 && (y == 26 || y == 34)) || (x == 72 && (y == 25 || y == 35)))
               RGB <= 16'b11111_111111_11111; // white D diagonals
           else if (x >= 72 && x <= 73 && y >= 26 && y <= 34)
               RGB <= 16'b11111_111111_11111; // white D second vertical
           else
               RGB <= black;
        end
    end
  end

               
endmodule
