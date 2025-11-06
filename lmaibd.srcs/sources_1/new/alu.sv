`timescale 1ns / 1ps


module alu(
input logic [3:0] alu_control_lines, 
input logic [31:0] in1, in2,
output logic [31:0] alu_out
);

always_comb begin
    case (alu_control_lines)
        4'b0000: alu_out = in1 & in2;
        4'b0001: alu_out = in1 | in2;
        4'b0010: alu_out = in1 + in2;
        4'b0110: alu_out = in1 - in2;
    endcase
end

endmodule
