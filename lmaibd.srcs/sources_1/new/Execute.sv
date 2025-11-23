`timescale 1ns / 1ps

module Execute(
input logic Jump, opcode3, ALUSrc,
input logic [31:0] data1, data2, extended_imm, pc,
input logic [2:0] funct3,
input logic [3:0] alu_control_lines,
output logic ToBranch,
output logic [31:0] alu_out, PCTarget
);

logic [31:0] PCTargetAdderInput, mux_out;
logic [3:0] ALUFlags; // N, Z, C, V

// deciding either to do PC + imm or data1 + imm.
// data1 comes from register file. Note that, we only select data1 for jalr instruction.
// Note: opcode3 means opcode[3]
mux uut_mux4(.in1(pc), .in2(data1), .BSel(Jump & (~opcode3)), .out(PCTargetAdderInput));

// calculating PCTarget for jalr, jalr and branch
adder uut_add2(.in1(extended_imm), .in2(PCTargetAdderInput), .out(PCTarget)); // calculates PCTarget for B and J type instructions

mux uut_mux1(.in1(data2), .in2(extended_imm), .BSel(ALUSrc), .out(mux_out));

// EXECUTE Stage
alu uut_alu(.alu_control_lines(alu_control_lines), .in1(data1), .in2(mux_out), .alu_out(alu_out), .ALUFlags(ALUFlags));

BranchUnit uut_branch(.ALUFlags(ALUFlags), .funct3(funct3), .ToBranch(ToBranch));

endmodule