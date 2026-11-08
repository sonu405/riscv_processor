`timescale 1ns / 1ps

`default_nettype none

module alu_control
  import alu_pkg::*;
(
    input wire [1:0] ALUOp,
    input wire [2:0] funct3,
    input wire op5,
    input wire funct7,  // funct7[5]
    output logic [3:0] alu_control_lines
);

  always_comb begin
    alu_control_lines = ALU_ADD;  // default

    case (ALUOp)
      // ADD: all loads and stores + jal and jalr
      2'b00: begin
        alu_control_lines = ALU_ADD;
      end
      // SUB: For all branches -- branch decision based on flags. 
      2'b01: begin
        alu_control_lines = ALU_SUB;
      end
      // For:
      // R-TYPE: add, sub, xor, or, and, sll, srl, sra, slt, sltu
      // I-TYPE: addi, xori, ori, andi, slli, srli, srai, slti, sltiu
      2'b10: begin
        case (funct3)
          3'b000: begin  // Add, sub, addi
            if ({op5, funct7} == 2'b11) alu_control_lines = ALU_SUB;
            else alu_control_lines = ALU_ADD;
          end
          3'b001: begin  // sll, slli
            alu_control_lines = ALU_SLL;
          end
          3'b010: begin  // slt, slti
            alu_control_lines = ALU_SLT;
          end
          3'b011: begin  // sltu, sltiu
            alu_control_lines = ALU_SLTU;  // TODO
          end
          3'b100: begin  // xor, xori
            alu_control_lines = ALU_XOR;  // TODO
          end
          3'b101: begin  // srl, sra, srli, srai
            if (funct7 == 1'b1) alu_control_lines = ALU_SRA;
            else alu_control_lines = ALU_SRL;
          end
          3'b110: begin  // or, ori
            alu_control_lines = ALU_OR;
          end
          3'b111: begin  // and, andi
            alu_control_lines = ALU_AND;
          end
        endcase
      end
      default: alu_control_lines = ALU_ADD;
    endcase
  end

endmodule

`default_nettype wire
