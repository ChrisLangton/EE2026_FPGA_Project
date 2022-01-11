`timescale 1ns / 1ps

module menu(input [3:0]curr_task, input left, mid, right, downbtn, clk6p25m, CLOCK, input [6:0]x, input [5:0]y, output reg [15:0]RGB = 1, input [3:0]mode, output reg[2:0] next_task = 0);
    //Colour Palettes
    parameter [15:0]background      = 16'hF655;
    parameter [15:0]welcome_border  = 16'hEC8E;
    parameter [15:0]select_border   = 16'hFA49;
    parameter [15:0]character       = 16'hFB26;
    parameter [15:0]mic             = 16'h39C7;
    parameter [15:0]music1          = 16'hFE00;
    parameter [15:0]music2          = 16'h0398;
    parameter [15:0]music3          = 16'h968A;
    parameter [15:0]white           = 16'hffff;    
    parameter [15:0]black           = 16'h0000;
    parameter [15:0]blue            = 16'h32B2;
    parameter [15:0]red2            = 16'hEC8E;
    parameter [15:0]yellow2         = 16'hFECC;   
    reg [15:0]cyan = 16'b00000_111111_11111;
    reg [15:0]light_gray = 16'b11001_110100_11001;
    reg [15:0]dark_gray = 16'b01011_011010_01011;
    reg [15:0]yellow = 16'b11111_111111_00000;
    reg [15:0]red = 16'b11111_00000_00000;
    reg [15:0]gold = 16'b11111_110100_00000;
    reg [2:0]up = 3'd4;
    reg [21:0]count = 22'd1;
    reg R3 = 0;
    reg L3 = 0;
    reg [5:0]down = 6'd30;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    wire clk4hz;
    new_clk clock(CLOCK, 32'd12499999, clk4hz); 
    reg [1:0]secondary_mode = 0; //default mode to specific where the border should be
    reg [4:0]sequence = 0;
    reg [1:0]last_button = 2'd1;
    reg flag = 0;
    always @ (posedge clk4hz) begin
        sequence <= (sequence == 10 && secondary_mode == 0) ? 0 : sequence + 1;
        if (secondary_mode != 0) sequence = 0;
    end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//always @ (left, right) begin
	  // secondary_mode <= (right == 1 && secondary_mode < 2) ? secondary_mode + 1 : (left == 1 && secondary_mode > 0) ? secondary_mode - 1 : secondary_mode;
	//end
	
    always @ (posedge clk6p25m) begin
        if (mode == 1) begin //This entire code only runs because we are in menu mode
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			if (right == 0 && left == 0 && mid == 0)
			 flag <= 0;		
			
			if (right == 1 && secondary_mode == 0 && flag == 0) begin
			 secondary_mode <= 1;
			 flag <= 1;
			end
			else if (right == 1 && secondary_mode == 1 && flag == 0) begin
			 secondary_mode <= 2;
			 flag <= 1;
			end
			else if (left == 1 && secondary_mode == 1 && flag == 0) begin
			 secondary_mode <= 0;
			 flag <= 1;
			end
			else if (left == 1 && secondary_mode == 2 && flag == 0) begin
			 secondary_mode <= 1;
			 flag <= 1;
			end
			
			if (secondary_mode == 0 && mid == 1)
			 next_task <= 2; //vol bar
			else if (secondary_mode == 1 && mid == 1)
			 next_task <= 3; //car game
			else if (secondary_mode == 2 && mid == 1)
			 next_task <= 4; // archery game
			if (downbtn == 1)
			 next_task <= 0;
			
			count <= count + 1;
			up <= (count == 0 && secondary_mode == 1) ? up + 1 : up;
			if (up == 0 || secondary_mode != 1)
				up <= 4;
			
			RGB <= background;
            if ((x >= 26 && x <= 70 && (y == 2 || y == 15)) || ((x == 26 || x == 70) && (y >= 2 && y <= 15))) RGB <= welcome_border; //Welcome Border
			if ((y >= 4 && y <= 12) && (x == 28 || x == 33 || x == 35 || x == 40 || x == 45 || x == 50 || x == 54 || x == 56 || x == 62 || x == 64)) RGB <= character; //All the Vertical Lines for welcome
			if (((x == 29 || x == 32) && (y == 10 || y == 11)) || ((x == 30 || x == 31) && (y == 9 || y == 10))) RGB <= character; 
			if ((x >= 36 && x <= 38) && (y == 4 || y == 8 || y == 12)) RGB <= character; //The ends of the first letter E
			if ((((x >= 41 && x <= 43) || (x >= 46 && x <= 48)) && y == 12) || ((x >= 46 && x <= 48) && y == 4)) RGB <= character;
			if (((x >= 51 && x <= 53) && (y == 4 || y == 12)) || ((x == 57 || x == 61) && (y == 5 || y == 6)) || ((x == 58 || x == 60) && (y == 6 || y == 7)) || (x == 59) && (y == 7 || y == 8)) RGB <= character;
			if ((x >= 65 && x <= 68) && (y == 4 || y == 8 || y == 12)) RGB <= character; //The ends of the second letter E
			/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if (secondary_mode == 0 ) begin //Left Border
                if (((x >= 2 && x <= 24) && (y == 2 || y == 62)) || ((x == 2 || x == 24) && (y >= 2 && y <= 62))) RGB <= select_border;
                if (sequence == 0) begin
                    if (y == 4 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                    if (y == 5 && (x >= 9 && x <= 17)) RGB <= mic;
                    if (y == 6 && (x >= 10 && x <= 16)) RGB <= mic;    
                    if (y == 59 && x == 7) RGB <= music1;
                    if (y == 49 && x == 12) RGB <= music2;
                    if ((y == 59 && x == 20) || (y == 60 && (x == 20 || x == 21))) RGB <= music3;
                end
                if (sequence == 1) begin
                    if (y == 4 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 5 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 6 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                    
                    if (y == 7 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                    if (y == 8 && (x >= 9 && x <= 17)) RGB <= mic;
                    if (y == 9 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 58 && (x == 5 || x == 6)) RGB <= music1;
                    if (y == 58 && x == 7) RGB <= music1;
                    if (y == 59 && (x == 7 || x == 8)) RGB <= music1;
                    if (y == 48 && x == 12) RGB <= music2;
                    if (y == 49 && (x == 11 || x == 12)) RGB <= music2;   
                    if ((y == 57 && x == 20) || (y == 58 && (x == 20 || x == 21))) RGB <= music3;
                    if ((y == 59 || y == 60) && (x == 19 || x == 21)) RGB <= music3;
                end
                if (sequence == 2) begin
                    if (y == 4 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 5 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                 
                    if (y == 6 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 7 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 8 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 9 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                    
                    if (y == 10 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                    if (y == 11 && (x >= 9 && x <= 17)) RGB <= mic;
                    if (y == 12 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 57 && x == 7) RGB <= music1;
                    if (y == 58 && (x == 7 || x == 8)) RGB <= music1; 
                    if (y == 59 && (x == 7 || x == 9)) RGB <= music1;  
                    if (y == 47 && x == 12) RGB <= music2;
                    if (y == 48 && (x == 11 || x == 12)) RGB <= music2;  
                    if (y == 49 && (x == 10 || x == 12)) RGB <= music2;
                    if ((y == 55 && x == 20) || (y == 56 && (x == 20 || x == 21))) RGB <= music3;
                    if ((y == 57 || y == 58) && (x == 19 || x == 21)) RGB <= music3;
                    if ((y == 59 || y == 60) && (x == 19 || x == 22)) RGB <= music3;
                end
                if (sequence == 3) begin
                    if (y == 4 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 5 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 6 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 7 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 8 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                 
                    if (y == 9 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 10 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 11 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 12 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                    
                    if (y == 13 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                    if (y == 14 && (x >= 9 && x <= 17)) RGB <= mic;
                    if (y == 15 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 56 && x == 7) RGB <= music1;
                    if (y == 57 && (x == 7 || x == 8)) RGB <= music1; 
                    if (y == 58 && (x == 7 || x == 9)) RGB <= music1;
                    if (y == 59 && x == 7) RGB <= music1; 
                    if (y == 46 && x == 12) RGB <= music2;
                    if (y == 47 && (x == 11 || x == 12)) RGB <= music2;  
                    if (y == 48 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 49 && x == 12) RGB <= music2;
                    if ((y == 53 && x == 20) || (y == 54 && (x == 20 || x == 21))) RGB <= music3;
                    if ((y == 55 || y == 56) && (x == 19 || x == 21)) RGB <= music3;
                    if ((y == 57 || y == 58) && (x == 19 || x == 22)) RGB <= music3;
                    if ((y == 58 || y == 59) && (x == 19 || x == 22)) RGB <= music3;
                end
                if (sequence == 4) begin
                    if (y == 4 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 5 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 6 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 7 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 8 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 9 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 10 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 11 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                 
                    if (y == 12 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 13 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 14 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 15 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                    
                    if (y == 16 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                    if (y == 17 && (x >= 9 && x <= 17)) RGB <= mic;
                    if (y == 18 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 55 && x == 7) RGB <= music1;
                    if (y == 56 && (x == 7 || x == 8)) RGB <= music1; 
                    if (y == 57 && (x == 7 || x == 9)) RGB <= music1;
                    if (y == 58 && x == 7) RGB <= music1;
                    if (y == 59 && x == 7) RGB <= music1;
                    if (y == 45 && x == 12) RGB <= music2;
                    if (y == 46 && (x == 11 || x == 12)) RGB <= music2;  
                    if (y == 47 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 48 && x == 12) RGB <= music2;
                    if (y == 49 && (x == 11 || x == 12)) RGB <= music2;
                    if ((y == 51 && x == 20) || (y == 52 && (x == 20 || x == 21))) RGB <= music3;
                    if ((y == 53 || y == 54) && (x == 19 || x == 21)) RGB <= music3;
                    if ((y == 55 || y == 56) && (x == 19 || x == 22)) RGB <= music3;
                    if ((y == 57 || y == 58) && (x == 19 || x == 22)) RGB <= music3;
                    if (((y == 59) && (x == 19 || x == 21)) || (y == 60 && x == 20)) RGB <= music3;
                end
                if (sequence == 5) begin
                    if (y == 4 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 5 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 6 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                                     
                    if (y == 7 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 8 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 9 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 10 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 11 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 12 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 13 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 14 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                 
                    if (y == 15 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 16 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 17 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 18 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                    
                    if (y == 19 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                    if (y == 20 && (x >= 9 && x <= 17)) RGB <= mic;
                    if (y == 21 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 54 && x == 7) RGB <= music1;
                    if (y == 55 && (x == 7 || x == 8)) RGB <= music1; 
                    if (y == 56 && (x == 7 || x == 9)) RGB <= music1;
                    if (y == 57 && x == 7) RGB <= music1;
                    if (y == 58 && x == 7) RGB <= music1;
                    if (y == 59 && x == 7) RGB <= music1;
                    if (y == 44 && x == 12) RGB <= music2;
                    if (y == 45 && (x == 11 || x == 12)) RGB <= music2;  
                    if (y == 46 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 47 && x == 12) RGB <= music2;
                    if (y == 48 && (x == 11 || x == 12)) RGB <= music2;
                    if (y == 49 && (x == 10 || x == 12)) RGB <= music2;
                    if ((y == 49 && x == 20) || (y == 50 && (x == 20 || x == 21))) RGB <= music3;
                    if ((y == 51 || y == 52) && (x == 19 || x == 21)) RGB <= music3;
                    if ((y == 53 || y == 54) && (x == 19 || x == 22)) RGB <= music3;
                    if ((y == 55 || y == 56) && (x == 19 || x == 22)) RGB <= music3;
                    if (((y == 57) && (x == 19 || x == 21)) || (y == 58 && x == 20)) RGB <= music3;
                    if (((y == 59) && (x == 19 || x == 20)) || (y == 60 && (x == 18 || x == 20))) RGB <= music3;
                end
                if (sequence == 6) begin                 
                    if (y == 4 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 5 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 6 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                    
                    if (y == 7 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 8 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 9 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                                     
                    if (y == 10 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 11 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 12 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 13 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 14 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 15 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 16 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 17 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                 
                    if (y == 18 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 19 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 20 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 21 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                    
                    if (y == 22 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                    if (y == 23 && (x >= 9 && x <= 17)) RGB <= mic;
                    if (y == 24 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 53 && x == 7) RGB <= music1;
                    if (y == 54 && (x == 7 || x == 8)) RGB <= music1; 
                    if (y == 55 && (x == 7 || x == 9)) RGB <= music1;
                    if (y == 56 && x == 7) RGB <= music1;
                    if (y == 57 && x == 7) RGB <= music1;
                    if (y == 58 && x == 7) RGB <= music1;
                    if (y == 59 && (x == 5 || x == 6 || x == 7)) RGB <= music1;
                    if (y == 43 && x == 12) RGB <= music2;
                    if (y == 44 && (x == 11 || x == 12)) RGB <= music2;  
                    if (y == 45 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 46 && x == 12) RGB <= music2;
                    if (y == 47 && (x == 11 || x == 12)) RGB <= music2;
                    if (y == 48 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 49 && (x >= 12 && x <= 14)) RGB <= music2;   
                    if ((y == 47 && x == 20) || (y == 48 && (x == 20 || x == 21))) RGB <= music3;
                    if ((y == 49 || y == 50) && (x == 19 || x == 21)) RGB <= music3;
                    if ((y == 51 || y == 52) && (x == 19 || x == 22)) RGB <= music3;
                    if ((y == 53 || y == 54) && (x == 19 || x == 22)) RGB <= music3;
                    if (((y == 55) && (x == 19 || x == 21)) || (y == 56 && x == 20)) RGB <= music3;
                    if (((y == 57) && (x == 19 || x == 20)) || (y == 58 && (x == 18 || x == 20))) RGB <= music3;
                    if ((y == 59 && (x == 17 || x == 20)) || (y ==  60 && (x == 17 || x == 20 || x == 21))) RGB <= music3;             
                end
                if (sequence == 7) begin
                    if (y == 4 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                    
                    if (y == 5 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 6 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 7 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 8 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 9 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                    
                    if (y == 10 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 11 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 12 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                                     
                    if (y == 13 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 14 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 15 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 16 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 17 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 18 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 19 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 20 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                 
                    if (y == 21 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 22 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 23 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 24 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                    
                    if (y == 25 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                    if (y == 26 && (x >= 9 && x <= 17)) RGB <= mic;
                    if (y == 27 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 52 && x == 7) RGB <= music1;
                    if (y == 53 && (x == 7 || x == 8)) RGB <= music1; 
                    if (y == 54 && (x == 7 || x == 9)) RGB <= music1;
                    if (y == 55 && x == 7) RGB <= music1;
                    if (y == 56 && x == 7) RGB <= music1;
                    if (y == 57 && x == 7) RGB <= music1;
                    if (y == 58 && (x == 5 || x == 6 || x == 7)) RGB <= music1;
                    if (y == 59 && (x == 4 || x == 7)) RGB <= music1;
                    if (y == 42 && x == 12) RGB <= music2;
                    if (y == 43 && (x == 11 || x == 12)) RGB <= music2;  
                    if (y == 44 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 45 && x == 12) RGB <= music2;
                    if (y == 46 && (x == 11 || x == 12)) RGB <= music2;
                    if (y == 47 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 48 && (x >= 12 && x <= 14)) RGB <= music2;
                    if (y == 49 && (x == 12 || x == 15)) RGB <= music2;
                    if ((y == 45 && x == 20) || (y == 46 && (x == 20 || x == 21))) RGB <= music3;
                    if ((y == 47 || y == 48) && (x == 19 || x == 21)) RGB <= music3;
                    if ((y == 49 || y == 50) && (x == 19 || x == 22)) RGB <= music3;
                    if ((y == 51 || y == 52) && (x == 19 || x == 22)) RGB <= music3;
                    if (((y == 53) && (x == 19 || x == 21)) || (y == 54 && x == 20)) RGB <= music3;
                    if (((y == 55) && (x == 19 || x == 20)) || (y == 56 && (x == 18 || x == 20))) RGB <= music3;
                    if ((y == 57 && (x == 17 || x == 20)) || (y == 58 && (x == 17 || x == 20 || x == 21))) RGB <= music3;
                    if ((y == 59 || y == 60) && (x == 17 || x == 19 || x == 20 || x == 22)) RGB <= music3;
                end
                if (sequence == 8) begin
                    if (y == 4 && (x >= 9 && x <= 17)) RGB <= mic;                    
                    if (y == 5 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;  
                    if (y == 6 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                                                          
                    if (y == 7 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                    
                    if (y == 8 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 9 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 10 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 11 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 12 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                    
                    if (y == 13 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 14 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 15 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                                     
                    if (y == 16 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 17 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 18 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 19 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 20 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 21 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 22 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 23 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                 
                    if (y == 24 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 25 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 26 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 27 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                    
                    if (y == 28 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                    if (y == 29 && (x >= 9 && x <= 17)) RGB <= mic;
                    if (y == 30 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 51 && x == 7) RGB <= music1;
                    if (y == 52 && (x == 7 || x == 8)) RGB <= music1; 
                    if (y == 53 && (x == 7 || x == 9)) RGB <= music1;
                    if (y == 54 && x == 7) RGB <= music1;
                    if (y == 55 && x == 7) RGB <= music1;
                    if (y == 56 && x == 7) RGB <= music1;
                    if (y == 57 && (x == 5 || x == 6 || x == 7)) RGB <= music1;
                    if (y == 58 && (x == 4 || x == 7)) RGB <= music1;
                    if (y == 59 && (x == 4 || x == 7)) RGB <= music1;
                    if (y == 41 && x == 12) RGB <= music2;
                    if (y == 42 && (x == 11 || x == 12)) RGB <= music2;  
                    if (y == 43 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 44 && x == 12) RGB <= music2;
                    if (y == 45 && (x == 11 || x == 12)) RGB <= music2;
                    if (y == 46 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 47 && (x >= 12 && x <= 14)) RGB <= music2;
                    if (y == 48 && (x == 12 || x == 15)) RGB <= music2;
                    if (y == 49 && (x == 12 || x == 15)) RGB <= music2;
                    if ((y == 43 && x == 20) || (y == 44 && (x == 20 || x == 21))) RGB <= music3;
                    if ((y == 45 || y == 46) && (x == 19 || x == 21)) RGB <= music3;
                    if ((y == 47 || y == 48) && (x == 19 || x == 22)) RGB <= music3;
                    if ((y == 49 || y == 50) && (x == 19 || x == 22)) RGB <= music3;
                    if (((y == 51) && (x == 19 || x == 21)) || (y == 52 && x == 20)) RGB <= music3;
                    if (((y == 53) && (x == 19 || x == 20)) || (y == 54 && (x == 18 || x == 20))) RGB <= music3;
                    if ((y == 55 && (x == 17 || x == 20)) || (y == 56 && (x == 17 || x == 20 || x == 21))) RGB <= music3;
                    if ((y == 57 || y == 58) && (x == 17 || x == 19 || x == 20 || x == 22)) RGB <= music3;
                    if ((y == 59 && (x == 17 || x == 20 || x == 22)) || (y == 60 && (x == 18 || x == 20 || x == 22))) RGB <= music3;
                end
                if (sequence == 9) begin
                    if ((y == 5 || y == 4) && (x >= 12 && x <= 14)) RGB <= mic;
                    if (y == 6 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 7 && (x >= 9 && x <= 17)) RGB <= mic;                    
                    if (y == 8 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;  
                    if (y == 9 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                                                          
                    if (y == 10 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                    
                    if (y == 11 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 12 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 13 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 14 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 15 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                    
                    if (y == 16 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 17 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 18 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                                     
                    if (y == 19 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 20 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 21 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 22 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 23 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 24 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 25 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 26 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                 
                    if (y == 27 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 28 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 29 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 30 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                    
                    if (y == 31 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                    if (y == 32 && (x >= 9 && x <= 17)) RGB <= mic;
                    if (y == 33 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 50 && x == 7) RGB <= music1;
                    if (y == 51 && (x == 7 || x == 8)) RGB <= music1; 
                    if (y == 52 && (x == 7 || x == 9)) RGB <= music1;
                    if (y == 53 && x == 7) RGB <= music1;
                    if (y == 54 && x == 7) RGB <= music1;
                    if (y == 55 && x == 7) RGB <= music1;
                    if (y == 56 && (x == 5 || x == 6 || x == 7)) RGB <= music1;
                    if (y == 57 && (x == 4 || x == 7)) RGB <= music1;
                    if (y == 58 && (x == 4 || x == 7)) RGB <= music1;
                    if (y == 59 && (x == 4 || x == 7)) RGB <= music1;
                    if (y == 40 && x == 12) RGB <= music2;
                    if (y == 41 && (x == 11 || x == 12)) RGB <= music2;  
                    if (y == 42 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 43 && x == 12) RGB <= music2;
                    if (y == 44 && (x == 11 || x == 12)) RGB <= music2;
                    if (y == 45 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 46 && (x >= 12 && x <= 14)) RGB <= music2;
                    if (y == 47 && (x == 12 || x == 15)) RGB <= music2;
                    if (y == 48 && (x == 12 || x == 15)) RGB <= music2;
                    if (y == 49 && (x == 12 || x == 15)) RGB <= music2;
                    if ((y == 41 && x == 20) || (y == 42 && (x == 20 || x == 21))) RGB <= music3;
                    if ((y == 43 || y == 44) && (x == 19 || x == 21)) RGB <= music3;
                    if ((y == 45 || y == 46) && (x == 19 || x == 22)) RGB <= music3;
                    if ((y == 47 || y == 48) && (x == 19 || x == 22)) RGB <= music3;
                    if (((y == 49) && (x == 19 || x == 21)) || (y == 50 && x == 20)) RGB <= music3;
                    if (((y == 51) && (x == 19 || x == 20)) || (y == 52 && (x == 18 || x == 20))) RGB <= music3;
                    if ((y == 53 && (x == 17 || x == 20)) || (y == 54 && (x == 17 || x == 20 || x == 21))) RGB <= music3;
                    if ((y == 55 || y == 56) && (x == 17 || x == 19 || x == 20 || x == 22)) RGB <= music3;
                    if ((y == 57 && (x == 17 || x == 20 || x == 22)) || (y == 58 && (x == 18 || x == 20 || x == 22))) RGB <= music3;
                    if ((y == 59 && (x >= 19 && x <= 21)) || (y == 60 && (x == 18 || x == 20))) RGB <= music3;
                end
                if (sequence == 10) begin
                    if (y == 5 && (x >= 9 && x <= 17)) RGB <= mic;
                    if ((y == 6 || y == 7 || y == 8) && (x >= 12 && x <= 14)) RGB <= mic;
                    if (y == 9 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 10 && (x >= 9 && x <= 17)) RGB <= mic;                    
                    if (y == 11 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;  
                    if (y == 12 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                                                          
                    if (y == 13 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                    
                    if (y == 14 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 15 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 16 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 17 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 18 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                    
                    if (y == 19 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 20 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 21 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                                     
                    if (y == 22 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 23 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 24 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 25 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 26 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 27 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 28 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 29 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                 
                    if (y == 30 && (x >= 7 && x <= 19)) RGB <= mic;
                    if (y == 31 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 32 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                    if (y == 33 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                    
                    if (y == 34 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                    if (y == 35 && (x >= 9 && x <= 17)) RGB <= mic;
                    if (y == 36 && (x >= 10 && x <= 16)) RGB <= mic;
                    if (y == 49 && x == 7) RGB <= music1;
                    if (y == 50 && (x == 7 || x == 8)) RGB <= music1; 
                    if (y == 51 && (x == 7 || x == 9)) RGB <= music1;
                    if (y == 52 && x == 7) RGB <= music1;
                    if (y == 53 && x == 7) RGB <= music1;
                    if (y == 54 && x == 7) RGB <= music1;
                    if (y == 55 && (x == 5 || x == 6 || x == 7)) RGB <= music1;
                    if (y == 56 && (x == 4 || x == 7)) RGB <= music1;
                    if (y == 57 && (x == 4 || x == 7)) RGB <= music1;
                    if (y == 58 && (x == 4 || x == 7)) RGB <= music1;
                    if (y == 59 && (x == 5 || x == 6)) RGB <= music1;
                    if (y == 39 && x == 12) RGB <= music2;
                    if (y == 40 && (x == 11 || x == 12)) RGB <= music2;  
                    if (y == 41 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 42 && x == 12) RGB <= music2;
                    if (y == 43 && (x == 11 || x == 12)) RGB <= music2;
                    if (y == 44 && (x == 10 || x == 12)) RGB <= music2;
                    if (y == 45 && (x >= 12 && x <= 14)) RGB <= music2;
                    if (y == 46 && (x == 12 || x == 15)) RGB <= music2;
                    if (y == 47 && (x == 12 || x == 15)) RGB <= music2;
                    if (y == 48 && (x == 12 || x == 15)) RGB <= music2;
                    if (y == 49 && (x == 13 || x == 14)) RGB <= music2;
                    if ((y == 39 && x == 20) || (y == 40 && (x == 20 || x == 21))) RGB <= music3;
                    if ((y == 41 || y == 42) && (x == 19 || x == 21)) RGB <= music3;
                    if ((y == 43 || y == 44) && (x == 19 || x == 22)) RGB <= music3;
                    if ((y == 45 || y == 46) && (x == 19 || x == 22)) RGB <= music3;
                    if (((y == 47) && (x == 19 || x == 21)) || (y == 48 && x == 20)) RGB <= music3;
                    if (((y == 49) && (x == 19 || x == 20)) || (y == 50 && (x == 18 || x == 20))) RGB <= music3;
                    if ((y == 51 && (x == 17 || x == 20)) || (y == 52 && (x == 17 || x == 20 || x == 21))) RGB <= music3;
                    if ((y == 53 || y == 54) && (x == 17 || x == 19 || x == 20 || x == 22)) RGB <= music3;
                    if ((y == 55 && (x == 17 || x == 20 || x == 22)) || (y == 56 && (x == 18 || x == 20 || x == 22))) RGB <= music3;
                    if ((y == 57 && (x >= 19 && x <= 21)) || ((y == 58 || y == 59) && (x == 18 || x == 20))) RGB <= music3;
                    if (y == 60 && x == 19) RGB <= music3;
                end
            end
			/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if (secondary_mode != 0) begin
                if (y == 5 && (x >= 9 && x <= 17)) RGB <= mic;
                if ((y == 6 || y == 7 || y == 8) && (x >= 12 && x <= 14)) RGB <= mic;
                if (y == 9 && (x >= 10 && x <= 16)) RGB <= mic;
                if (y == 10 && (x >= 9 && x <= 17)) RGB <= mic;                    
                if (y == 11 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;  
                if (y == 12 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                                                          
                if (y == 13 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                    
                if (y == 14 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 15 && (x >= 7 && x <= 19)) RGB <= mic;
                if (y == 16 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 17 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 18 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                    
                if (y == 19 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 20 && (x >= 7 && x <= 19)) RGB <= mic;
                if (y == 21 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                                     
                if (y == 22 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 23 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 24 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 25 && (x >= 7 && x <= 19)) RGB <= mic;
                if (y == 26 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 27 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 28 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 29 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;                 
                if (y == 30 && (x >= 7 && x <= 19)) RGB <= mic;
                if (y == 31 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 32 && (x == 7 || x == 11 || x == 15 || x == 19)) RGB <= mic;
                if (y == 33 && (x == 7 || x == 8 || x == 11 || x == 15 || x == 18 || x == 19)) RGB <= mic;                    
                if (y == 34 && (x == 8 || x == 9 || x == 11 || x == 15 || x == 17 || x == 18)) RGB <= mic;
                if (y == 35 && (x >= 9 && x <= 17)) RGB <= mic;
                if (y == 36 && (x >= 10 && x <= 16)) RGB <= mic;
                if (y == 49 && x == 7) RGB <= music1;
                if (y == 50 && (x == 7 || x == 8)) RGB <= music1; 
                if (y == 51 && (x == 7 || x == 9)) RGB <= music1;
                if (y == 52 && x == 7) RGB <= music1;
                if (y == 53 && x == 7) RGB <= music1;
                if (y == 54 && x == 7) RGB <= music1;
                if (y == 55 && (x == 5 || x == 6 || x == 7)) RGB <= music1;
                if (y == 56 && (x == 4 || x == 7)) RGB <= music1;
                if (y == 57 && (x == 4 || x == 7)) RGB <= music1;
                if (y == 58 && (x == 4 || x == 7)) RGB <= music1;
                if (y == 59 && (x == 5 || x == 6)) RGB <= music1;
                if (y == 39 && x == 12) RGB <= music2;
                if (y == 40 && (x == 11 || x == 12)) RGB <= music2;  
                if (y == 41 && (x == 10 || x == 12)) RGB <= music2;
                if (y == 42 && x == 12) RGB <= music2;
                if (y == 43 && (x == 11 || x == 12)) RGB <= music2;
                if (y == 44 && (x == 10 || x == 12)) RGB <= music2;
                if (y == 45 && (x >= 12 && x <= 14)) RGB <= music2;
                if (y == 46 && (x == 12 || x == 15)) RGB <= music2;
                if (y == 47 && (x == 12 || x == 15)) RGB <= music2;
                if (y == 48 && (x == 12 || x == 15)) RGB <= music2;
                if (y == 49 && (x == 13 || x == 14)) RGB <= music2;
                if ((y == 39 && x == 20) || (y == 40 && (x == 20 || x == 21))) RGB <= music3;
                if ((y == 41 || y == 42) && (x == 19 || x == 21)) RGB <= music3;
                if ((y == 43 || y == 44) && (x == 19 || x == 22)) RGB <= music3;
                if ((y == 45 || y == 46) && (x == 19 || x == 22)) RGB <= music3;
                if (((y == 47) && (x == 19 || x == 21)) || (y == 48 && x == 20)) RGB <= music3;
                if (((y == 49) && (x == 19 || x == 20)) || (y == 50 && (x == 18 || x == 20))) RGB <= music3;
                if ((y == 51 && (x == 17 || x == 20)) || (y == 52 && (x == 17 || x == 20 || x == 21))) RGB <= music3;
                if ((y == 53 || y == 54) && (x == 17 || x == 19 || x == 20 || x == 22)) RGB <= music3;
                if ((y == 55 && (x == 17 || x == 20 || x == 22)) || (y == 56 && (x == 18 || x == 20 || x == 22))) RGB <= music3;
                if ((y == 57 && (x >= 19 && x <= 21)) || ((y == 58 || y == 59) && (x == 18 || x == 20))) RGB <= music3;
                if (y == 60 && x == 19) RGB <= music3;        
            end
		if (secondary_mode == 1) begin //Middle Border
			if (((y == 17 || y == 62) && (x >= 26 && x <= 70)) || ((x == 26 || x == 70) && (y >= 17 && y <= 62))) RGB <= select_border;
		end
                // DRAW CAR////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                if (((x == 44 || x == 52) && ((y >= 52-up && y <= 54-up) || (y >= 60-up && y <= 62-up))) || ((y == 63-up || y == 61-up) && x >= 46 && x <= 50)) 
                	RGB <= black; // wheels and spoiler
                else if (((x == 45 || x == 51) && ((y >= 52-up && y <= 54-up) || (y >= 60-up && y <= 62-up))) || ((x == 46 || x == 50) && ((y >= 51-up && y <= 53-up) || (y >= 59-up && y <= 61-up))) || (x == 44 && y == 55-up) || (x == 52 && y == 55-up) || (x == 48 && y >= 50-up && y <= 53-up))
                    RGB <= cyan; // front body
                else if ((y == 54-up && x >= 46 && x <= 50) || (y == 55-up && x >= 45 && x <= 51) || ((x == 45 || x == 51) && y >= 57-up && y <= 59-up))
                    RGB <= dark_gray; // window visors
                else if (((x == 45 || x == 51) && y == 51-up) || ((x == 46 || x == 50) && y == 50-up))
                    RGB <= yellow; // headlights
                else if (((x >= 45 && x <= 46) && (y == 56-up || y == 60-up || y == 63-up)) || ((x == 46 || x == 50) && (y >= 57-up && y <= 59-up)) || ((x == 45 || x == 51) && y == 61-up) || (x >= 50 && x <= 51 && y == 56-up) || (x == 48 && ((y >= 56-up && y <= 60-up) || y == 62-up)))
                    RGB <= cyan; // back body
                else if ((x == 47 || x == 49) && ((y >= 50-up && y <= 53-up) || (y >= 56-up && y <= 60-up) || (y == 62-up)))
                    RGB <= light_gray; // racing stripes
                else if (y == 63-up && (x == 45 || x == 51))
                    RGB <= red; // tail lights  
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
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if (secondary_mode == 2) begin //Middle Border
		  if (((y == 2 || y == 62) && (x >= 72 && x <= 94)) || ((y >= 2 && y <= 62) && (x == 72 || x == 94))) RGB <= select_border;
		end
        if ((y >= 7 && y <= 58) && (x >= 74 && x <= 92)) RGB <= white;
        if ((y >= 10 && y <= 55) && (x >= 76 && x <= 90)) RGB <= black;
        if ((y >= 13 && y <= 52) && (x >= 78 && x <= 88)) RGB <= blue;
        if ((y >= 17 && y <= 46) && (x >= 80 && x <= 86)) RGB <= red2;
        if ((y >= 24 && x <= 39) && (x >= 82 && x <= 84)) RGB <= yellow2;
        end
    end
endmodule