`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2021 10:53:35
// Design Name: 
// Module Name: new_clk
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
module new_clk(input CLOCK, input [31:0] flip_count, output reg clk = 0);
    reg [31:0]count = 32'b0;
    always @ (posedge CLOCK)
    begin
        count <= (count == flip_count) ? 0 : count + 1;
        clk <= (count == flip_count) ? ~clk : clk;
    end
endmodule