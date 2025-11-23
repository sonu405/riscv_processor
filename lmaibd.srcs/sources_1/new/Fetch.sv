`timescale 1ns / 1ps

module Fetch(
    input logic clk, rst, Branch, ToBranch, Jump,
    input logic [31:0]  PCTarget,
    output logic [31:0] pc, instruction, PCPlus4
);

logic [31:0] PCNext;

// mux selecting PC + 4 or either PC + imm or PC + reg for B and J type instructions.
// The input logic only selects the case other than PC + 4 when we have to 
// do branch after it has been checked to be true or we have to jump.
mux uut_mux3(.in1(PCPlus4), .in2(PCTarget), .BSel((ToBranch & Branch) | Jump), .out(PCNext));
progcounter pc_uut(.clk(clk), .rst(rst), .PCNext(PCNext),.pc(pc));

// adder for => PC + 4
adder uut_add1(.in1(pc), .in2(4), .out(PCPlus4)); 

// Instruction memory
instruction_mem inst_uut(.pc(pc), .instruction(instruction));
endmodule