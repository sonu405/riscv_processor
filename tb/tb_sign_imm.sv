`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2025 02:56:40 PM
// Design Name: 
// Module Name: tb_sign_imm
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


module tb_sign_imm();

logic [11:0] immediate_gen;
logic [31:0] out;

immediate_gen uut(.imm(immediate_gen), .out(out));
initial begin 
    #10 immediate_gen = 10;
    #10 immediate_gen = 50;
end
    
endmodule
