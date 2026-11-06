`timescale 1ns / 1ps

module Writeback (
    input  logic [ 1:0] ResultSrc,
    input  logic [ 2:0] funct3,
    input  logic [31:0] alu_out,
    input  logic [31:0] RD,
    input  logic [31:0] PCPlus4,
    output logic [31:0] Result
);

  logic [31:0] load_data;
  logic [31:0] shifted;

  /*
  It isn't necessary that the lb byte would be on the LSB of the word read from
  memory. The byte could be anywhere in the word, depending on the address. So
  we shift the word right by 8 * (address[1:0]) to get the byte in the LSB
  position. Then we sign-extend or zero-extend as appropriate.

  btw, address here comes from alu_out
  */

  assign shifted = RD >> (8 * alu_out[1:0]);

  always_comb begin
    case (funct3)
      3'b000:  load_data = {{24{shifted[7]}}, shifted[7:0]};  // lb
      3'b001:  load_data = {{16{shifted[15]}}, shifted[15:0]};  // lh
      3'b010:  load_data = RD;  // lw
      3'b100:  load_data = {{24{1'b0}}, shifted[7:0]};  // lbu
      3'b101:  load_data = {{16{1'b0}}, shifted[15:0]};  // lhu 
      default: load_data = RD;
    endcase
  end


  // Result Mux: choose the input that is written into the register file
  // in1 -- alu_out
  // in2 -- Data read by data memory
  // in3 -- PC + 4 -- for jump instruction's rd field
  // in4 -- potentially extended imm for LUI
  fourby1mux uut_fourby1mux (
      .in1 (alu_out),
      .in2 (load_data),
      .in3 (PCPlus4),
      .in4 (32'b0),
      .BSel(ResultSrc),
      .out (Result)
  );
endmodule
