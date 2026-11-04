`timescale 1ns / 1ps


module mux(
input logic [31:0] in1, in2,
input logic BSel,
output logic [31:0] out
);
always_comb begin
    if (BSel) out = in2;
    else begin
        out = in1;
    end
end
endmodule
