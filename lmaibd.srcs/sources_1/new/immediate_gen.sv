`timescale 1ns / 1ps

module immediate_gen(input logic [31:0] instr, input logic [1:0] ImmSrc, output logic [31:0] out);

always_comb begin
    case (ImmSrc)
        2'b00: begin // I TYPE 
            out = {{20{instr[31]}}, instr[31:20]};
        end
        2'b01: begin // S Type
            out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
        end
        2'b10: begin // B-Type
            out = {{19{instr[31]}},instr[31],instr[7], instr[30:25], instr[11:8], 1'b0};
        end
        2'b11: begin // J-Type
            out = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21],1'b0};
        end
    endcase
end

endmodule
