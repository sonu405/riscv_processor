`timescale 1ns / 1ps
`default_nettype none

module instruction_mem (
    input  wire  [31:0] addr,
    output logic [31:0] instruction,

    // BRAM Port B
    input wire [31:0] bram_dout
);

  always_comb begin
    instruction = bram_dout;
  end

endmodule

`default_nettype wire
