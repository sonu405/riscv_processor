`timescale 1ns / 1ps
`default_nettype none

// Every ALU operation can be performed with 4 basic operations, add, sub, 
package alu_pkg;
  typedef enum logic [3:0] {
    ALU_AND  = 4'b0000,
    ALU_OR   = 4'b0001,
    ALU_ADD  = 4'b0010,
    ALU_SLTU = 4'b0011,
    ALU_SUB  = 4'b0110,
    ALU_SLT  = 4'b0111,
    ALU_XOR  = 4'b1000,
    ALU_SLL  = 4'b1001,
    ALU_SRL  = 4'b1010,
    ALU_SRA  = 4'b1011
    // ALU_PASS_B = 4'b1010   // LUI
  } alu_op_e;
endpackage

`default_nettype wire
