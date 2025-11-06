`timescale 1ns / 1ps

module immediate_gen(input logic [31:0] instr, input logic [1:0] ImmSrc, output logic [31:0] out);

always_comb begin
    case (ImmSrc)
        2'b00: begin // I TYPE
            out = {{20{instr[31]}}, instr[31:20]};
        end
        2'b01: begin // I TYPE
            out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
        end
//        EXTEND FOR J, BEQ      
    endcase
end

endmodule
