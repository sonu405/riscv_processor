`timescale 1ns / 1ps

module Writeback(
input logic [1:0] ResultSrc,
input logic [31:0] alu_out, RD, PCPlus4,
output logic [31:0] Result
);

// Result Mux: choose the input that is written into the register file
// in1 -- alu_out
// in2 -- Data read by data memory
// in3 -- PC + 4 -- for jump instruction's rd field
// in4 -- potentially extended imm for LUI
fourby1mux uut_fourby1mux (.in1(alu_out), .in2(RD), .in3(PCPlus4), .in4(32'b0), .BSel(ResultSrc), .out(Result));
endmodule