`timescale 1ns / 1ps

module Fetch (
    input logic clk,
    input logic rst,
    input logic Branch,
    input logic ToBranch,
    input logic Jump,
    input logic PCWrite,
    input logic [31:0] PCTarget,
    output logic [31:0] pc,
    output logic [31:0] instruction,
    output logic [31:0] PCPlus4,

    // Instruction Memory BRAM PORT B
    output logic [31:0] imem_addr,
    input  logic [31:0] imem_dout
);

  logic [31:0] PCNext;

  // mux selecting PC + 4 or either PC + imm or PC + reg for B and J type instructions.
  // The input logic only selects the case other than PC + 4 when we have to 
  // do branch after it has been checked to be true or we have to jump.
  mux uut_mux3 (
      .in1 (PCPlus4),
      .in2 (PCTarget),
      .BSel((ToBranch & Branch) | Jump),
      .out (PCNext)
  );
  progcounter pc_uut (
      .clk(clk),
      .rst(rst),
      .PCWrite(PCWrite),
      .PCNext(PCNext),
      .pc(pc)
  );

  // adder for => PC + 4
  adder uut_add1 (
      .in1(pc),
      .in2(4),
      .out(PCPlus4)
  );

  // The BRAM has 1 cycle of latency, so it is given the address the PC is
  // ABOUT to hold. After the clock edge, pc and instruction match.
  //   reset      -> word 0
  //   PCWrite=1  -> PCNext (normal, branch, jump)
  //   PCWrite=0  -> pc (stall: re-read the same word so the output holds)
  always_comb begin
    instruction = imem_dout;
    imem_addr   = rst ? 32'b0 : (PCWrite ? PCNext : pc);
  end

endmodule
