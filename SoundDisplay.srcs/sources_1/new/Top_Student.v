`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): THURSDAY A.M.
//
//  STUDENT A NAME: Christopher Nge
//  STUDENT A MATRICULATION NUMBER: A0218109J
//
//  STUDENT B NAME: Christopher Tze-Wen Langton
//  STUDENT B MATRICULATION NUMBER: A0219607B
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input CLOCK,
    input btnC,
    input btnL,
    input btnR,
    input btnU,
    input btnD,
    input [15:0]sw,
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,   // Connect to this signal from Audio_Capture.v
    output [15:0]led,
    output reg [3:0]an = 4'b1111,
    output reg [6:0]seg = 7'b1111111,
    output dp,
    output cs,
    output sdin,
    output sclk,
    output d_cn,
    output resn,
    output vccen,
    output pmoden
    );
    
       
    assign dp = 1;
    wire [15:0] RGB;
    wire [15:0] rgbreg0;
    wire [15:0] rgbreg1;
    wire [15:0] rgbreg2;
    wire [15:0] rgbreg3;
    wire [15:0] rgbreg4;
    wire task0_done;
    wire task1_done;
    wire task2_done;
    wire endgame;
    wire [3:0]anreg0;
    wire [6:0]segreg0;
    wire [3:0]anreg1;
    wire [6:0]segreg1;
    wire [3:0]anreg2;
    wire [6:0]segreg2;
    wire [3:0]anreg3;
    wire [6:0]segreg3;
    
    
    wire [2:0]next_task;
    reg [3:0]curr_task;
    
    wire frame_begin, sending_pixels, sample_pixel; //ignore for now
    wire [12:0]pixel_index;
    wire clk6p25m; //6.25MHz CLOCK
    wire clk30hz;
    
    wire reset; //btnC
    wire sp_btnL;
    wire sp_btnR;
    wire sp_btnU;
    wire sp_btnD;
    wire SLOW_CLOCK;
    slow_clock dut1 (CLOCK, SLOW_CLOCK);
    single_pulse spmod_btnC (SLOW_CLOCK, btnC, reset);
    single_pulse spmod_btnL (SLOW_CLOCK, btnL, sp_btnL);
    single_pulse spmod_btnR (SLOW_CLOCK, btnR, sp_btnR);
    single_pulse spmod_btnU (SLOW_CLOCK, btnU, sp_btnU);
    single_pulse spmod_btnD (SLOW_CLOCK, btnD, sp_btnD);
    
    wire clk20khz, clk10hz, clk40khz, clk381hz;
    new_clk clock1(CLOCK, 32'd2499, clk20khz); //20Khz Clock
    new_clk clock3(CLOCK, 32'd1666667, clk30hz);
    new_clk clock2(CLOCK, 32'd4999999, clk10hz); //10Hz Clock
    new_clk clock4(CLOCK, 32'd1170, clk40khz); //42.7Khz Clock
    new_clk dut4 (CLOCK, 32'd7, clk6p25m); //6.25MHz CLOCK
    new_clk clock5(CLOCK, 32'd131232, clk381hz); //381Hz Clock
        
        
    wire [12:0]x = pixel_index % 96;
    assign x = pixel_index % 96;
    wire [12:0]y = pixel_index / 96;
    assign y = pixel_index / 96;
        
        
    wire [15:0]mic_in;
    wire [2:0]freq_range; 
    wire [15:0]freq_sound;
    Audio_Capture test(CLOCK, clk20khz, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, mic_in);
    menu menu(curr_task, sp_btnL, sp_btnU, sp_btnR, sp_btnD, clk6p25m, CLOCK, x, y, rgbreg1, curr_task, next_task);
    
    wire [3:0]sound_level;
    wire [15:0]max;
    find_max mod2(sw[5], CLOCK, mic_in, max);
    Audio_Indicator mod3(sw[1], curr_task, CLOCK, max, led, anreg0, segreg0, sound_level);
    sound_freq mod5(curr_task, clk381hz, clk20khz, mic_in, 32'd19999, anreg2, segreg2, freq_sound);

    
    draw_oled_bars dut2 (clk6p25m, sp_btnL, sp_btnR, reset, freq_sound, sw[0], sw[1], sw[2], sw[3], sw[10], x, y, rgbreg2, sound_level , curr_task);
    draw_lock_screen dut3 (clk6p25m, curr_task, sp_btnL, sp_btnR, reset, sw[15], sw[14], sw[13], sw[12], x, y, rgbreg0, task0_done, sound_level);
    car_game car (clk6p25m, clk10hz, CLOCK, curr_task, sp_btnL, sp_btnR, sp_btnU, sp_btnD, x, y, rgbreg3, endgame, anreg1, segreg1, sound_level);
    Oled_Display dut5 (clk6p25m, reset, frame_begin, sending_pixels, sample_pixel, pixel_index, RGB, cs, sdin, sclk, d_cn, resn, vccen, pmoden);
    Archery_Game arch (curr_task, CLOCK, sp_btnU, sp_btnD, sp_btnR, sw, sound_level, freq_sound, x, y, rgbreg4, segreg3, anreg3);
    
    control dut6 (CLOCK, curr_task, rgbreg0, rgbreg1, rgbreg2, rgbreg3, rgbreg4, RGB);
    
    always @(posedge CLOCK) begin
        if (curr_task == 2 && sw[10] == 0) begin
            an <= anreg0;
            seg <= segreg0;
        end
        if (curr_task == 2 && sw[10] == 1) begin
            an <= anreg2;
            seg <= segreg2;
        end
        if (curr_task == 3) begin
            an <= anreg1;
            seg <= segreg1;
        end
        if (curr_task == 4) begin 
            an <= anreg3;
            seg <= segreg3;
        end
        
        if (sp_btnD == 1)
            curr_task <= 1;
        else if (curr_task == 0 && task0_done == 1)
            curr_task <= 4'd1; //menu
        else if (curr_task == 1 && next_task == 2)
            curr_task <= 4'd2; //volume bar
        else if (curr_task == 1 && next_task == 3)
            curr_task <= 4'd3; //car game
        else if (curr_task == 1 && next_task == 4)
            curr_task <= 4'd4; //archery game
        
        if (curr_task == 1) begin
            an <= 4'b1111;
            seg <= 7'b1111111; 
        end
    end
    
    
            
endmodule