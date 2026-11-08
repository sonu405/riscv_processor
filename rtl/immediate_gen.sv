`timescale 1ns / 1ps

module immediate_gen (
    input  wire  [31:0] instr,
    input  wire  [ 2:0] ImmSrc,
    output logic [31:0] out
);

  always_comb begin
    case (ImmSrc)
      3'b000: begin  // I TYPE 
        out = {{20{instr[31]}}, instr[31:20]};
      end
      3'b001: begin  // S Type
        out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
      end
      3'b010: begin  // B-Type
        out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
      end
      3'b011: begin  // J-Type
        out = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
      end
      3'b100: begin  // U-Type
        out = {instr[31:12], 12'b0};
      end
    endcase
  end

endmodule
