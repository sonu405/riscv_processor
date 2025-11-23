`timescale 1ns / 1ps

module Decode(
input logic clk, RegWrite,
input logic [1:0] ImmSrc,
input logic [31:0] instruction, dataW,
input logic [4:0] rdWD, // rd for WD
output logic [6:0] opcode, funct7,
output logic [4:0] rd,  // rd decoded
output logic [31:0] data1, data2, extended_imm,
output logic [2:0] funct3
);

logic [4:0] rs1, rs2;
assign rs1 = instruction[19:15];       // 5 bits
assign rs2 = instruction[24:20];       // 5 bits

always_comb begin
    // Immediate is splitted by extend unit based on the signal by control unit.
    opcode = instruction[6:0];      // 7 bits
    rd = instruction[11:7];         // 5 bits
    funct3 = instruction[14:12];    // 3 bits 
    funct7 = instruction[31:25];    // 7 bits 
end

reg_file uut_regfile(.RegWrite(RegWrite),.clk(clk), .rsW(rd), 
            .rs1(rs1), .rs2(rs2), .dataW(dataW), .out1(data1), .out2(data2));
            
immediate_gen imm_gen_uut(.instr(instruction), .ImmSrc(ImmSrc), .out(extended_imm));
endmodule
