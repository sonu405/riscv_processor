`timescale 1ns / 1ps


module immediate_gen(input logic [11:0] imm, output logic [31:0] out);

always_comb begin
    out = {{20{imm[11]}}, imm[11:0]};
end

endmodule
