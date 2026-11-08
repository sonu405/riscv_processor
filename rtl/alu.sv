`timescale 1ns / 1ps


module alu
  import alu_pkg::*;
(
    input wire [3:0] alu_control_lines,
    input wire [31:0] in1,
    input wire [31:0] in2,
    output logic [31:0] alu_out,
    output logic [3:0] ALUFlags  // N, Z, C, V
);

  logic [32:0] sum_ext;  // bit 32 = carry-out
  logic        is_sub;
  logic        is_addsub;

  assign is_sub    = (alu_control_lines == ALU_SUB);
  assign is_addsub = (alu_control_lines == ALU_ADD) || is_sub;

  /*

  Note: a xor 0 = a
        a xor 1 = ~a

  a - b = a + (~b) + 1
  a + b = a + (b)  + 0
  One shared adder: in1 + (in2 or ~in2) + (1 if sub).
  */
  assign sum_ext = {1'b0, in1} + {1'b0, in2 ^ {32{is_sub}}} + 33'(is_sub);

  always_comb begin
    alu_out = '0;

    case (alu_control_lines)
      ALU_AND:  alu_out = in1 & in2;
      ALU_OR:   alu_out = in1 | in2;
      // ALUFlags[1] is carryout
      ALU_ADD:  alu_out = sum_ext[31:0];
      ALU_SUB:  alu_out = sum_ext[31:0];
      //   ALU_SUB: begin
      //     {ALUFlags[1], alu_out} = in1 - in2;
      //     ALUFlags[1] = ~ALUFlags[1]; // This is because in the above, in1 - in2 gave us the borrow and carry out = ~borrow.
      //   end
      ALU_SLT:  alu_out = ($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0;
      ALU_SLTU: alu_out = (in1 < in2) ? 32'b1 : 32'b0;
      ALU_SLL:  alu_out = in1 << in2[4:0];
      ALU_SRL:  alu_out = in1 >> in2[4:0];
      ALU_SRA:  alu_out = $signed(in1) >>> in2[4:0];
      ALU_XOR:  alu_out = in1 ^ in2;
      //   ALU_PASS_B: alu_out = in2;  // LUI
      default:  alu_out = '0;
    endcase
  end

  logic n, z, c, v;

  assign z = (alu_out == 32'b0);  // Zero flag
  assign n = alu_out[31];  // negative bit (MSB = 1)
  assign c = is_addsub & sum_ext[32];

  // Overflow flag
  // Add: same-sign operands, result sign differs.
  // Sub: opposite-sign operands (in1 and ~in2 same sign), result sign differs from in1.
  logic a_sign, b_sign, r_sign;

  assign a_sign = in1[31];

  // For sub, adder sees in2 as ~in2, so we need to xor with is_sub to get the original sign of in2.
  assign b_sign = in2[31] ^ is_sub;
  assign r_sign = sum_ext[31];

  assign v = is_addsub & (a_sign == b_sign) & (r_sign != a_sign);

  assign ALUFlags = {n, z, c, v};

endmodule
