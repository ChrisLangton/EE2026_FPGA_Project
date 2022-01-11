`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2021 15:15:23
// Design Name: 
// Module Name: draw_oled_bars
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


module draw_oled_bars(
    input CLOCK_6_25MHZ,
    input sp_btnL,
    input sp_btnR,
    input sp_btnC,
    input [15:0]freq_sound,
    input sw0, // colour theme
    input sw1, // border size
    input sw2, // hide border
    input sw3, // hide volume bars
    input sw10, //switch to freq mode
    input [12:0]x,
    input [12:0]y,
    output reg [15:0]RGB,
    input [3:0]sound_level,
    input [3:0]curr_task
    );
    
    reg [1:0]flag = 2'b0;
    
always @ (posedge CLOCK_6_25MHZ) begin
   if (curr_task == 2) begin
    if (sw10 == 0) begin
     if (sp_btnC == 1)
           flag <= 0;
     if (sp_btnL == 1)
           flag <= 1;
     if (sp_btnR == 1)
           flag <= 2;
      if (sw0 == 0) begin
       if (flag == 0) begin
        if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
            RGB <= 16'b11111_111111_11111; // white
        else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
            RGB <= 16'b11111_111111_11111; // white
        else if (x >= 41 && x <= 53 && y >= 7 && y <= 8 && sound_level == 15 && sw3 == 0)
            RGB <= 16'b11111_000000_00000; // red 1
        else if (x >= 41 && x <= 53 && y >= 10 && y <= 11 && sound_level >= 14 && sw3 == 0)
            RGB <= 16'b11111_000000_00000; // red 2
        else if (x >= 41 && x <= 53 && y >= 13 && y <= 14 && sound_level >= 13 && sw3 == 0)
            RGB <= 16'b11111_000000_00000; // red 3
        else if (x >= 41 && x <= 53 && y >= 16 && y <= 17 && sound_level >= 12 && sw3 == 0)
            RGB <= 16'b11111_000000_00000; // red 4
        else if (x >= 41 && x <= 53 && y >= 19 && y <= 20 && sound_level >= 11 && sw3 == 0)
            RGB <= 16'b11111_000000_00000; // red 5
        else if (x >= 41 && x <= 53 && y >= 22 && y <= 23 && sound_level >= 10 && sw3 == 0)
            RGB <= 16'b11111_111111_00000; // yellow 1
        else if (x >= 41 && x <= 53 && y >= 25 && y <= 26 && sound_level >= 9 && sw3 == 0)
            RGB <= 16'b11111_111111_00000; // yellow 2
        else if (x >= 41 && x <= 53 && y >= 28 && y <= 29 && sound_level >= 8 && sw3 == 0)
            RGB <= 16'b11111_111111_00000; // yellow 3
        else if (x >= 41 && x <= 53 && y >= 31 && y <= 32 && sound_level >= 7 && sw3 == 0)
            RGB <= 16'b11111_111111_00000; // yellow 4
        else if (x >= 41 && x <= 53 && y >= 34 && y <= 35 && sound_level >= 6 && sw3 == 0)
            RGB <= 16'b11111_111111_00000; // yellow 5
        else if (x >= 41 && x <= 53 && y >= 37 && y <= 38 && sound_level >= 5 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 1
        else if (x >= 41 && x <= 53 && y >= 40 && y <= 41 && sound_level >= 4 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 2
        else if (x >= 41 && x <= 53 && y >= 43 && y <= 44 && sound_level >= 3 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 3
        else if (x >= 41 && x <= 53 && y >= 46 && y <= 47 && sound_level >= 2 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 4
        else if (x >= 41 && x <= 53 && y >= 49 && y <= 50 && sound_level >= 1 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 5
        else if (x >= 41 && x <= 53 && y >= 52 && y <= 53 && sound_level >= 0 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 6*/
        else 
            RGB <= 16'b00000_000000_00000; // black
      end
      
      //shift bar left
       if (flag == 1) begin
        if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
            RGB <= 16'b11111_111111_11111; // white
        else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
            RGB <= 16'b11111_111111_11111; // white
        else if (x >= 21 && x <= 33 && y >= 7 && y <= 8 && sound_level == 15 && sw3 == 0)
            RGB <= 16'b11111_000000_00000; // red 1
        else if (x >= 21 && x <= 33 && y >= 10 && y <= 11 && sound_level >= 14 && sw3 == 0)
            RGB <= 16'b11111_000000_00000; // red 2
        else if (x >= 21 && x <= 33 && y >= 13 && y <= 14 && sound_level >= 13 && sw3 == 0)
            RGB <= 16'b11111_000000_00000; // red 3
        else if (x >= 21 && x <= 33 && y >= 16 && y <= 17 && sound_level >= 12 && sw3 == 0)
            RGB <= 16'b11111_000000_00000; // red 4
        else if (x >= 21 && x <= 33 && y >= 19 && y <= 20 && sound_level >= 11 && sw3 == 0)
            RGB <= 16'b11111_000000_00000; // red 5
        else if (x >= 21 && x <= 33 && y >= 22 && y <= 23 && sound_level >= 10 && sw3 == 0)
            RGB <= 16'b11111_111111_00000; // yellow 1
        else if (x >= 21 && x <= 33 && y >= 25 && y <= 26 && sound_level >= 9 && sw3 == 0)
            RGB <= 16'b11111_111111_00000; // yellow 2
        else if (x >= 21 && x <= 33 && y >= 28 && y <= 29 && sound_level >= 8 && sw3 == 0)
            RGB <= 16'b11111_111111_00000; // yellow 3
        else if (x >= 21 && x <= 33 && y >= 31 && y <= 32 && sound_level >= 7 && sw3 == 0)
            RGB <= 16'b11111_111111_00000; // yellow 4
        else if (x >= 21 && x <= 33 && y >= 34 && y <= 35 && sound_level >= 6 && sw3 == 0)
            RGB <= 16'b11111_111111_00000; // yellow 5
        else if (x >= 21 && x <= 33 && y >= 37 && y <= 38 && sound_level >= 5 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 1
        else if (x >= 21 && x <= 33 && y >= 40 && y <= 41 && sound_level >= 4 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 2
        else if (x >= 21 && x <= 33 && y >= 43 && y <= 44 && sound_level >= 3 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 3
        else if (x >= 21 && x <= 33 && y >= 46 && y <= 47 && sound_level >= 2 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 4
        else if (x >= 21 && x <= 33 && y >= 49 && y <= 50 && sound_level >= 1 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 5
        else if (x >= 21 && x <= 33 && y >= 52 && y <= 53 && sound_level >= 0 && sw3 == 0)
            RGB <= 16'b00000_111111_00000; // green 6*/
        else 
            RGB <= 16'b00000_000000_00000; // black
       end
        
        //shift bar right
       if (flag == 2) begin
          if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
              RGB <= 16'b11111_111111_11111; // white
          else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
              RGB <= 16'b11111_111111_11111; // white
          else if (x >= 61 && x <= 73 && y >= 7 && y <= 8 && sound_level == 15 && sw3 == 0)
              RGB <= 16'b11111_000000_00000; // red 1
          else if (x >= 61 && x <= 73 && y >= 10 && y <= 11 && sound_level >= 14 && sw3 == 0)
              RGB <= 16'b11111_000000_00000; // red 2
          else if (x >= 61 && x <= 73 && y >= 13 && y <= 14 && sound_level >= 13 && sw3 == 0)
              RGB <= 16'b11111_000000_00000; // red 3
          else if (x >= 61 && x <= 73 && y >= 16 && y <= 17 && sound_level >= 12 && sw3 == 0)
              RGB <= 16'b11111_000000_00000; // red 4
          else if (x >= 61 && x <= 73 && y >= 19 && y <= 20 && sound_level >= 11 && sw3 == 0)
              RGB <= 16'b11111_000000_00000; // red 5
          else if (x >= 61 && x <= 73 && y >= 22 && y <= 23 && sound_level >= 10 && sw3 == 0)
              RGB <= 16'b11111_111111_00000; // yellow 1
          else if (x >= 61 && x <= 73 && y >= 25 && y <= 26 && sound_level >= 9 && sw3 == 0)
              RGB <= 16'b11111_111111_00000; // yellow 2
          else if (x >= 61 && x <= 73 && y >= 28 && y <= 29 && sound_level >= 8 && sw3 == 0)
              RGB <= 16'b11111_111111_00000; // yellow 3
          else if (x >= 61 && x <= 73 && y >= 31 && y <= 32 && sound_level >= 7 && sw3 == 0)
              RGB <= 16'b11111_111111_00000; // yellow 4
          else if (x >= 61 && x <= 73 && y >= 34 && y <= 35 && sound_level >= 6 && sw3 == 0)
              RGB <= 16'b11111_111111_00000; // yellow 5
          else if (x >= 61 && x <= 73 && y >= 37 && y <= 38 && sound_level >= 5 && sw3 == 0)
              RGB <= 16'b00000_111111_00000; // green 1
          else if (x >= 61 && x <= 73 && y >= 40 && y <= 41 && sound_level >= 4 && sw3 == 0)
              RGB <= 16'b00000_111111_00000; // green 2
          else if (x >= 61 && x <= 73 && y >= 43 && y <= 44 && sound_level >= 3 && sw3 == 0)
              RGB <= 16'b00000_111111_00000; // green 3
          else if (x >= 61 && x <= 73 && y >= 46 && y <= 47 && sound_level >= 2 && sw3 == 0)
              RGB <= 16'b00000_111111_00000; // green 4
          else if (x >= 61 && x <= 73 && y >= 49 && y <= 50 && sound_level >= 1 && sw3 == 0)
              RGB <= 16'b00000_111111_00000; // green 5
          else if (x >= 61 && x <= 73 && y >= 52 && y <= 53 && sound_level >= 0 && sw3 == 0)
              RGB <= 16'b00000_111111_00000; // green 6*/
          else 
              RGB <= 16'b00000_000000_00000; // black
        end
      end
      
      
      //other colour scheme
      if (sw0 == 1) begin
       if (flag == 0) begin
         if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
             RGB <= 16'b00000_000000_11111; // blue border
         else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
             RGB <= 16'b00000_000000_11111; // blue
         else if (x >= 41 && x <= 53 && y >= 7 && y <= 8 && sound_level == 15 && sw3 == 0)
             RGB <= 16'b00000_000000_00000; // red 1
         else if (x >= 41 && x <= 53 && y >= 10 && y <= 11 && sound_level >= 14 && sw3 == 0)
             RGB <= 16'b00000_000000_00000; // red 2
         else if (x >= 41 && x <= 53 && y >= 13 && y <= 14 && sound_level >= 13 && sw3 == 0)
             RGB <= 16'b00000_000000_00000; // red 3
         else if (x >= 41 && x <= 53 && y >= 16 && y <= 17 && sound_level >= 12 && sw3 == 0)
             RGB <= 16'b00000_000000_00000; // red 4
         else if (x >= 41 && x <= 53 && y >= 19 && y <= 20 && sound_level >= 11 && sw3 == 0)
             RGB <= 16'b00000_000000_00000; // red 5
         else if (x >= 41 && x <= 53 && y >= 22 && y <= 23 && sound_level >= 10 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // yellow 1
         else if (x >= 41 && x <= 53 && y >= 25 && y <= 26 && sound_level >= 9 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // yellow 2
         else if (x >= 41 && x <= 53 && y >= 28 && y <= 29 && sound_level >= 8 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // yellow 3
         else if (x >= 41 && x <= 53 && y >= 31 && y <= 32 && sound_level >= 7 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // yellow 4
         else if (x >= 41 && x <= 53 && y >= 34 && y <= 35 && sound_level >= 6 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // yellow 5
         else if (x >= 41 && x <= 53 && y >= 37 && y <= 38 && sound_level >= 5 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 1
         else if (x >= 41 && x <= 53 && y >= 40 && y <= 41 && sound_level >= 4 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 2
         else if (x >= 41 && x <= 53 && y >= 43 && y <= 44 && sound_level >= 3 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 3
         else if (x >= 41 && x <= 53 && y >= 46 && y <= 47 && sound_level >= 2 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 4
         else if (x >= 41 && x <= 53 && y >= 49 && y <= 50 && sound_level >= 1 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 5
         else if (x >= 41 && x <= 53 && y >= 52 && y <= 53 && sound_level >= 0 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 6*/
         else 
             RGB <= 16'b11111_000000_11111; // PURPLE
       end
       
       //shift bar left
       if (flag == 1) begin
         if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
             RGB <= 16'b00000_000000_11111; // BLUE
         else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
              RGB <= 16'b00000_000000_11111; // blue
         else if (x >= 21 && x <= 33 && y >= 7 && y <= 8 && sound_level == 15 && sw3 == 0)
             RGB <= 16'b00000_000000_00000; // red 1
         else if (x >= 21 && x <= 33 && y >= 10 && y <= 11 && sound_level >= 14 && sw3 == 0)
             RGB <= 16'b00000_000000_00000; // red 2
         else if (x >= 21 && x <= 33 && y >= 13 && y <= 14 && sound_level >= 13 && sw3 == 0)
             RGB <= 16'b00000_000000_00000; // red 3
         else if (x >= 21 && x <= 33 && y >= 16 && y <= 17 && sound_level >= 12 && sw3 == 0)
             RGB <= 16'b00000_000000_00000; // red 4
         else if (x >= 21 && x <= 33 && y >= 19 && y <= 20 && sound_level >= 11 && sw3 == 0)
             RGB <= 16'b00000_000000_00000; // red 5
         else if (x >= 21 && x <= 33 && y >= 22 && y <= 23 && sound_level >= 10 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // yellow 1
         else if (x >= 21 && x <= 33 && y >= 25 && y <= 26 && sound_level >= 9 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // yellow 2
         else if (x >= 21 && x <= 33 && y >= 28 && y <= 29 && sound_level >= 8 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // yellow 3
         else if (x >= 21 && x <= 33 && y >= 31 && y <= 32 && sound_level >= 7 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // yellow 4
         else if (x >= 21 && x <= 33 && y >= 34 && y <= 35 && sound_level >= 6 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // yellow 5
         else if (x >= 21 && x <= 33 && y >= 37 && y <= 38 && sound_level >= 5 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 1
         else if (x >= 21 && x <= 33 && y >= 40 && y <= 41 && sound_level >= 4 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 2
         else if (x >= 21 && x <= 33 && y >= 43 && y <= 44 && sound_level >= 3 && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 3
         else if (x >= 21 && x <= 33 && y >= 46 && y <= 47 && sound_level >= 2  && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 4
         else if (x >= 21 && x <= 33 && y >= 49 && y <= 50 && sound_level >= 1  && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 5
         else if (x >= 21 && x <= 33 && y >= 52 && y <= 53 && sound_level >= 0  && sw3 == 0)
             RGB <= 16'b11111_111111_11111; // green 6*/
         else 
             RGB <= 16'b11111_000000_11111; // PURPLE
       end
         
         //shift bar right
       if (flag == 2) begin
           if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
               RGB <= 16'b00000_000000_11111; // BLUE
           else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
               RGB <= 16'b00000_000000_11111; // blue
           else if (x >= 61 && x <= 73 && y >= 7 && y <= 8 && sound_level == 15 && sw3 == 0)
               RGB <= 16'b00000_000000_00000; // red 1
           else if (x >= 61 && x <= 73 && y >= 10 && y <= 11 && sound_level >= 14 && sw3 == 0)
               RGB <= 16'b00000_000000_00000; // red 2
           else if (x >= 61 && x <= 73 && y >= 13 && y <= 14 && sound_level >= 13 && sw3 == 0)
               RGB <= 16'b00000_000000_00000; // red 3
           else if (x >= 61 && x <= 73 && y >= 16 && y <= 17 && sound_level >= 12 && sw3 == 0)
               RGB <= 16'b00000_000000_00000; // red 4
           else if (x >= 61 && x <= 73 && y >= 19 && y <= 20 && sound_level >= 11 && sw3 == 0)
               RGB <= 16'b00000_000000_00000; // red 5
           else if (x >= 61 && x <= 73 && y >= 22 && y <= 23 && sound_level >= 10 && sw3 == 0)
               RGB <= 16'b11111_111111_11111; // yellow 1
           else if (x >= 61 && x <= 73 && y >= 25 && y <= 26 && sound_level >= 9 && sw3 == 0)
               RGB <= 16'b11111_111111_11111; // yellow 2
           else if (x >= 61 && x <= 73 && y >= 28 && y <= 29 && sound_level >= 8 && sw3 == 0)
               RGB <= 16'b11111_111111_11111; // yellow 3
           else if (x >= 61 && x <= 73 && y >= 31 && y <= 32 && sound_level >= 7 && sw3 == 0)
               RGB <= 16'b11111_111111_11111; // yellow 4
           else if (x >= 61 && x <= 73 && y >= 34 && y <= 35 && sound_level >= 6 && sw3 == 0)
               RGB <= 16'b11111_111111_11111; // yellow 5
           else if (x >= 61 && x <= 73 && y >= 37 && y <= 38 && sound_level >= 5 && sw3 == 0)
               RGB <= 16'b11111_111111_11111; // green 1
           else if (x >= 61 && x <= 73 && y >= 40 && y <= 41 && sound_level >= 4 && sw3 == 0)
               RGB <= 16'b11111_111111_11111; // green 2
           else if (x >= 61 && x <= 73 && y >= 43 && y <= 44 && sound_level >= 3 && sw3 == 0)
               RGB <= 16'b11111_111111_11111; // green 3
           else if (x >= 61 && x <= 73 && y >= 46 && y <= 47 && sound_level >= 2 && sw3 == 0)
               RGB <= 16'b11111_111111_11111; // green 4
           else if (x >= 61 && x <= 73 && y >= 49 && y <= 50 && sound_level >= 1 && sw3 == 0)
               RGB <= 16'b11111_111111_11111; // green 5
           else if (x >= 61 && x <= 73 && y >= 52 && y <= 53 && sound_level >= 0  && sw3 == 0)
               RGB <= 16'b11111_111111_11111; // green 6*/
           else 
               RGB <= 16'b11111_000000_11111; // PURPLE
         end
      end
    end
    if (sw10 == 1) begin
         if (sp_btnC == 1)
               flag <= 0;
         if (sp_btnL == 1)
               flag <= 1;
         if (sp_btnR == 1)
               flag <= 2;
          if (sw0 == 0) begin
           if (flag == 0) begin
            if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
                RGB <= 16'b11111_111111_11111; // white
            else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
                RGB <= 16'b11111_111111_11111; // white
            else if (x >= 41 && x <= 53 && y >= 7 && y <= 8 && freq_sound == 15 && sw3 == 0)
                RGB <= 16'b11111_000000_00000; // red 1
            else if (x >= 41 && x <= 53 && y >= 10 && y <= 11 && freq_sound >= 14 && sw3 == 0)
                RGB <= 16'b11111_000000_00000; // red 2
            else if (x >= 41 && x <= 53 && y >= 13 && y <= 14 && freq_sound >= 13 && sw3 == 0)
                RGB <= 16'b11111_000000_00000; // red 3
            else if (x >= 41 && x <= 53 && y >= 16 && y <= 17 && freq_sound >= 12 && sw3 == 0)
                RGB <= 16'b11111_000000_00000; // red 4
            else if (x >= 41 && x <= 53 && y >= 19 && y <= 20 && freq_sound >= 11 && sw3 == 0)
                RGB <= 16'b11111_000000_00000; // red 5
            else if (x >= 41 && x <= 53 && y >= 22 && y <= 23 && freq_sound >= 10 && sw3 == 0)
                RGB <= 16'b11111_111111_00000; // yellow 1
            else if (x >= 41 && x <= 53 && y >= 25 && y <= 26 && freq_sound >= 9 && sw3 == 0)
                RGB <= 16'b11111_111111_00000; // yellow 2
            else if (x >= 41 && x <= 53 && y >= 28 && y <= 29 && freq_sound >= 8 && sw3 == 0)
                RGB <= 16'b11111_111111_00000; // yellow 3
            else if (x >= 41 && x <= 53 && y >= 31 && y <= 32 && freq_sound >= 7 && sw3 == 0)
                RGB <= 16'b11111_111111_00000; // yellow 4
            else if (x >= 41 && x <= 53 && y >= 34 && y <= 35 && freq_sound >= 6 && sw3 == 0)
                RGB <= 16'b11111_111111_00000; // yellow 5
            else if (x >= 41 && x <= 53 && y >= 37 && y <= 38 && freq_sound >= 5 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 1
            else if (x >= 41 && x <= 53 && y >= 40 && y <= 41 && freq_sound >= 4 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 2
            else if (x >= 41 && x <= 53 && y >= 43 && y <= 44 && freq_sound >= 3 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 3
            else if (x >= 41 && x <= 53 && y >= 46 && y <= 47 && freq_sound >= 2 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 4
            else if (x >= 41 && x <= 53 && y >= 49 && y <= 50 && freq_sound >= 1 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 5
            else if (x >= 41 && x <= 53 && y >= 52 && y <= 53 && freq_sound >= 0 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 6*/
            else 
                RGB <= 16'b00000_000000_00000; // black
          end
          
          //shift bar left
           if (flag == 1) begin
            if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
                RGB <= 16'b11111_111111_11111; // white
            else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
                RGB <= 16'b11111_111111_11111; // white
            else if (x >= 21 && x <= 33 && y >= 7 && y <= 8 && freq_sound == 15 && sw3 == 0)
                RGB <= 16'b11111_000000_00000; // red 1
            else if (x >= 21 && x <= 33 && y >= 10 && y <= 11 && freq_sound >= 14 && sw3 == 0)
                RGB <= 16'b11111_000000_00000; // red 2
            else if (x >= 21 && x <= 33 && y >= 13 && y <= 14 && freq_sound >= 13 && sw3 == 0)
                RGB <= 16'b11111_000000_00000; // red 3
            else if (x >= 21 && x <= 33 && y >= 16 && y <= 17 && freq_sound >= 12 && sw3 == 0)
                RGB <= 16'b11111_000000_00000; // red 4
            else if (x >= 21 && x <= 33 && y >= 19 && y <= 20 && freq_sound >= 11 && sw3 == 0)
                RGB <= 16'b11111_000000_00000; // red 5
            else if (x >= 21 && x <= 33 && y >= 22 && y <= 23 && freq_sound >= 10 && sw3 == 0)
                RGB <= 16'b11111_111111_00000; // yellow 1
            else if (x >= 21 && x <= 33 && y >= 25 && y <= 26 && freq_sound >= 9 && sw3 == 0)
                RGB <= 16'b11111_111111_00000; // yellow 2
            else if (x >= 21 && x <= 33 && y >= 28 && y <= 29 && freq_sound >= 8 && sw3 == 0)
                RGB <= 16'b11111_111111_00000; // yellow 3
            else if (x >= 21 && x <= 33 && y >= 31 && y <= 32 && freq_sound >= 7 && sw3 == 0)
                RGB <= 16'b11111_111111_00000; // yellow 4
            else if (x >= 21 && x <= 33 && y >= 34 && y <= 35 && freq_sound >= 6 && sw3 == 0)
                RGB <= 16'b11111_111111_00000; // yellow 5
            else if (x >= 21 && x <= 33 && y >= 37 && y <= 38 && freq_sound >= 5 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 1
            else if (x >= 21 && x <= 33 && y >= 40 && y <= 41 && freq_sound >= 4 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 2
            else if (x >= 21 && x <= 33 && y >= 43 && y <= 44 && freq_sound >= 3 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 3
            else if (x >= 21 && x <= 33 && y >= 46 && y <= 47 && freq_sound >= 2 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 4
            else if (x >= 21 && x <= 33 && y >= 49 && y <= 50 && freq_sound >= 1 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 5
            else if (x >= 21 && x <= 33 && y >= 52 && y <= 53 && freq_sound >= 0 && sw3 == 0)
                RGB <= 16'b00000_111111_00000; // green 6*/
            else 
                RGB <= 16'b00000_000000_00000; // black
           end
            
            //shift bar right
           if (flag == 2) begin
              if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
                  RGB <= 16'b11111_111111_11111; // white
              else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
                  RGB <= 16'b11111_111111_11111; // white
              else if (x >= 61 && x <= 73 && y >= 7 && y <= 8 && freq_sound == 15 && sw3 == 0)
                  RGB <= 16'b11111_000000_00000; // red 1
              else if (x >= 61 && x <= 73 && y >= 10 && y <= 11 && freq_sound >= 14 && sw3 == 0)
                  RGB <= 16'b11111_000000_00000; // red 2
              else if (x >= 61 && x <= 73 && y >= 13 && y <= 14 && freq_sound >= 13 && sw3 == 0)
                  RGB <= 16'b11111_000000_00000; // red 3
              else if (x >= 61 && x <= 73 && y >= 16 && y <= 17 && freq_sound >= 12 && sw3 == 0)
                  RGB <= 16'b11111_000000_00000; // red 4
              else if (x >= 61 && x <= 73 && y >= 19 && y <= 20 && freq_sound >= 11 && sw3 == 0)
                  RGB <= 16'b11111_000000_00000; // red 5
              else if (x >= 61 && x <= 73 && y >= 22 && y <= 23 && freq_sound >= 10 && sw3 == 0)
                  RGB <= 16'b11111_111111_00000; // yellow 1
              else if (x >= 61 && x <= 73 && y >= 25 && y <= 26 && freq_sound >= 9 && sw3 == 0)
                  RGB <= 16'b11111_111111_00000; // yellow 2
              else if (x >= 61 && x <= 73 && y >= 28 && y <= 29 && freq_sound >= 8 && sw3 == 0)
                  RGB <= 16'b11111_111111_00000; // yellow 3
              else if (x >= 61 && x <= 73 && y >= 31 && y <= 32 && freq_sound >= 7 && sw3 == 0)
                  RGB <= 16'b11111_111111_00000; // yellow 4
              else if (x >= 61 && x <= 73 && y >= 34 && y <= 35 && freq_sound >= 6 && sw3 == 0)
                  RGB <= 16'b11111_111111_00000; // yellow 5
              else if (x >= 61 && x <= 73 && y >= 37 && y <= 38 && freq_sound >= 5 && sw3 == 0)
                  RGB <= 16'b00000_111111_00000; // green 1
              else if (x >= 61 && x <= 73 && y >= 40 && y <= 41 && freq_sound >= 4 && sw3 == 0)
                  RGB <= 16'b00000_111111_00000; // green 2
              else if (x >= 61 && x <= 73 && y >= 43 && y <= 44 && freq_sound >= 3 && sw3 == 0)
                  RGB <= 16'b00000_111111_00000; // green 3
              else if (x >= 61 && x <= 73 && y >= 46 && y <= 47 && freq_sound >= 2 && sw3 == 0)
                  RGB <= 16'b00000_111111_00000; // green 4
              else if (x >= 61 && x <= 73 && y >= 49 && y <= 50 && freq_sound >= 1 && sw3 == 0)
                  RGB <= 16'b00000_111111_00000; // green 5
              else if (x >= 61 && x <= 73 && y >= 52 && y <= 53 && freq_sound >= 0 && sw3 == 0)
                  RGB <= 16'b00000_111111_00000; // green 6*/
              else 
                  RGB <= 16'b00000_000000_00000; // black
            end
          end
          
          
          //other colour scheme
          if (sw0 == 1) begin
           if (flag == 0) begin
             if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
                 RGB <= 16'b00000_000000_11111; // blue border
             else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
                 RGB <= 16'b00000_000000_11111; // blue
             else if (x >= 41 && x <= 53 && y >= 7 && y <= 8 && freq_sound == 15 && sw3 == 0)
                 RGB <= 16'b00000_000000_00000; // red 1
             else if (x >= 41 && x <= 53 && y >= 10 && y <= 11 && freq_sound >= 14 && sw3 == 0)
                 RGB <= 16'b00000_000000_00000; // red 2
             else if (x >= 41 && x <= 53 && y >= 13 && y <= 14 && freq_sound >= 13 && sw3 == 0)
                 RGB <= 16'b00000_000000_00000; // red 3
             else if (x >= 41 && x <= 53 && y >= 16 && y <= 17 && freq_sound >= 12 && sw3 == 0)
                 RGB <= 16'b00000_000000_00000; // red 4
             else if (x >= 41 && x <= 53 && y >= 19 && y <= 20 && freq_sound >= 11 && sw3 == 0)
                 RGB <= 16'b00000_000000_00000; // red 5
             else if (x >= 41 && x <= 53 && y >= 22 && y <= 23 && freq_sound >= 10 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // yellow 1
             else if (x >= 41 && x <= 53 && y >= 25 && y <= 26 && freq_sound >= 9 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // yellow 2
             else if (x >= 41 && x <= 53 && y >= 28 && y <= 29 && freq_sound >= 8 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // yellow 3
             else if (x >= 41 && x <= 53 && y >= 31 && y <= 32 && freq_sound >= 7 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // yellow 4
             else if (x >= 41 && x <= 53 && y >= 34 && y <= 35 && freq_sound >= 6 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // yellow 5
             else if (x >= 41 && x <= 53 && y >= 37 && y <= 38 && freq_sound >= 5 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 1
             else if (x >= 41 && x <= 53 && y >= 40 && y <= 41 && freq_sound >= 4 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 2
             else if (x >= 41 && x <= 53 && y >= 43 && y <= 44 && freq_sound >= 3 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 3
             else if (x >= 41 && x <= 53 && y >= 46 && y <= 47 && freq_sound >= 2 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 4
             else if (x >= 41 && x <= 53 && y >= 49 && y <= 50 && freq_sound >= 1 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 5
             else if (x >= 41 && x <= 53 && y >= 52 && y <= 53 && freq_sound >= 0 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 6*/
             else 
                 RGB <= 16'b11111_000000_11111; // PURPLE
           end
           
           //shift bar left
           if (flag == 1) begin
             if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
                 RGB <= 16'b00000_000000_11111; // BLUE
             else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
                  RGB <= 16'b00000_000000_11111; // blue
             else if (x >= 21 && x <= 33 && y >= 7 && y <= 8 && freq_sound == 15 && sw3 == 0)
                 RGB <= 16'b00000_000000_00000; // red 1
             else if (x >= 21 && x <= 33 && y >= 10 && y <= 11 && freq_sound >= 14 && sw3 == 0)
                 RGB <= 16'b00000_000000_00000; // red 2
             else if (x >= 21 && x <= 33 && y >= 13 && y <= 14 && freq_sound >= 13 && sw3 == 0)
                 RGB <= 16'b00000_000000_00000; // red 3
             else if (x >= 21 && x <= 33 && y >= 16 && y <= 17 && freq_sound >= 12 && sw3 == 0)
                 RGB <= 16'b00000_000000_00000; // red 4
             else if (x >= 21 && x <= 33 && y >= 19 && y <= 20 && freq_sound >= 11 && sw3 == 0)
                 RGB <= 16'b00000_000000_00000; // red 5
             else if (x >= 21 && x <= 33 && y >= 22 && y <= 23 && freq_sound >= 10 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // yellow 1
             else if (x >= 21 && x <= 33 && y >= 25 && y <= 26 && freq_sound >= 9 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // yellow 2
             else if (x >= 21 && x <= 33 && y >= 28 && y <= 29 && freq_sound >= 8 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // yellow 3
             else if (x >= 21 && x <= 33 && y >= 31 && y <= 32 && freq_sound >= 7 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // yellow 4
             else if (x >= 21 && x <= 33 && y >= 34 && y <= 35 && freq_sound >= 6 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // yellow 5
             else if (x >= 21 && x <= 33 && y >= 37 && y <= 38 && freq_sound >= 5 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 1
             else if (x >= 21 && x <= 33 && y >= 40 && y <= 41 && freq_sound >= 4 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 2
             else if (x >= 21 && x <= 33 && y >= 43 && y <= 44 && freq_sound >= 3 && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 3
             else if (x >= 21 && x <= 33 && y >= 46 && y <= 47 && freq_sound >= 2  && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 4
             else if (x >= 21 && x <= 33 && y >= 49 && y <= 50 && freq_sound >= 1  && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 5
             else if (x >= 21 && x <= 33 && y >= 52 && y <= 53 && freq_sound >= 0  && sw3 == 0)
                 RGB <= 16'b11111_111111_11111; // green 6*/
             else 
                 RGB <= 16'b11111_000000_11111; // PURPLE
           end
             
             //shift bar right
           if (flag == 2) begin
               if (((y == 0) || (y == 63) || (x == 0) || (x == 95)) && (sw1 == 0) && (sw2 == 0)) // border
                   RGB <= 16'b00000_000000_11111; // BLUE
               else if (((y >= 0 && y <= 2) || (y >= 61 && y <= 63) || (x >= 0 && x <= 2) || (x >= 93 && x <= 95)) && (sw1 == 1))
                   RGB <= 16'b00000_000000_11111; // blue
               else if (x >= 61 && x <= 73 && y >= 7 && y <= 8 && freq_sound == 15 && sw3 == 0)
                   RGB <= 16'b00000_000000_00000; // red 1
               else if (x >= 61 && x <= 73 && y >= 10 && y <= 11 && freq_sound >= 14 && sw3 == 0)
                   RGB <= 16'b00000_000000_00000; // red 2
               else if (x >= 61 && x <= 73 && y >= 13 && y <= 14 && freq_sound >= 13 && sw3 == 0)
                   RGB <= 16'b00000_000000_00000; // red 3
               else if (x >= 61 && x <= 73 && y >= 16 && y <= 17 && freq_sound >= 12 && sw3 == 0)
                   RGB <= 16'b00000_000000_00000; // red 4
               else if (x >= 61 && x <= 73 && y >= 19 && y <= 20 && freq_sound >= 11 && sw3 == 0)
                   RGB <= 16'b00000_000000_00000; // red 5
               else if (x >= 61 && x <= 73 && y >= 22 && y <= 23 && freq_sound >= 10 && sw3 == 0)
                   RGB <= 16'b11111_111111_11111; // yellow 1
               else if (x >= 61 && x <= 73 && y >= 25 && y <= 26 && freq_sound >= 9 && sw3 == 0)
                   RGB <= 16'b11111_111111_11111; // yellow 2
               else if (x >= 61 && x <= 73 && y >= 28 && y <= 29 && freq_sound >= 8 && sw3 == 0)
                   RGB <= 16'b11111_111111_11111; // yellow 3
               else if (x >= 61 && x <= 73 && y >= 31 && y <= 32 && freq_sound >= 7 && sw3 == 0)
                   RGB <= 16'b11111_111111_11111; // yellow 4
               else if (x >= 61 && x <= 73 && y >= 34 && y <= 35 && freq_sound >= 6 && sw3 == 0)
                   RGB <= 16'b11111_111111_11111; // yellow 5
               else if (x >= 61 && x <= 73 && y >= 37 && y <= 38 && freq_sound >= 5 && sw3 == 0)
                   RGB <= 16'b11111_111111_11111; // green 1
               else if (x >= 61 && x <= 73 && y >= 40 && y <= 41 && freq_sound >= 4 && sw3 == 0)
                   RGB <= 16'b11111_111111_11111; // green 2
               else if (x >= 61 && x <= 73 && y >= 43 && y <= 44 && freq_sound >= 3 && sw3 == 0)
                   RGB <= 16'b11111_111111_11111; // green 3
               else if (x >= 61 && x <= 73 && y >= 46 && y <= 47 && freq_sound >= 2 && sw3 == 0)
                   RGB <= 16'b11111_111111_11111; // green 4
               else if (x >= 61 && x <= 73 && y >= 49 && y <= 50 && freq_sound >= 1 && sw3 == 0)
                   RGB <= 16'b11111_111111_11111; // green 5
               else if (x >= 61 && x <= 73 && y >= 52 && y <= 53 && freq_sound >= 0  && sw3 == 0)
                   RGB <= 16'b11111_111111_11111; // green 6*/
               else 
                   RGB <= 16'b11111_000000_11111; // PURPLE
             end
          end
        end
  end
 end
        
endmodule
