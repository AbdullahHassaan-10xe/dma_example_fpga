`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 12:09:34 PM
// Design Name: 
// Module Name: bram_sum
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


module bram_sum(

    input clk,
    input reset,
    input start,
    output reg done,
    output reg [31:0] sum,
    output reg [11:0] addr,
    input [31:0] data

    );
parameter MAX = 1023;

reg en_sum;
reg en_addr;
reg en_addr_2;

always@(posedge clk) done <= ~en_sum; 

always@(*) en_addr = start & addr != MAX;

always@(posedge clk)
    if (reset || !start) begin
        en_addr_2 <= 0;
        en_sum <= 0;
    end
    else begin
        en_addr_2 <= en_addr;
        //en_sum <= en_addr_2;
        en_sum <= en_addr;
    end
    
always@(posedge clk)
    if (reset || !start) addr <= 0;
    else if (en_addr) addr <= addr + 1;
    
always@(posedge clk)
    if (reset || !start) sum <= 0;
    else if (en_sum) sum <= sum + data;
    
endmodule
