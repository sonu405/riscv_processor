`timescale 1ns / 1ps

`default_nettype none

module adder (
    input  wire  [31:0] in1,
    input  wire  [31:0] in2,
    output logic [31:0] out
);

  always_comb begin
    out = in1 + in2;
  end

endmodule

`default_nettype wire
