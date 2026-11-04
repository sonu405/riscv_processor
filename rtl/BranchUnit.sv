`timescale 1ns / 1ps

module BranchUnit(
input logic [3:0] ALUFlags, // N, Z, C, V 
input logic [2:0] funct3,
output logic ToBranch
);

logic L; // A < B

always_comb begin
    if ((funct3 == 3'b100) || (funct3 == 3'b101)) // signed numbers
        L = ALUFlags[3] ^ ALUFlags[0];  // L = N xor V
    else
        L = ~ALUFlags[1];

    case(funct3)
    // beq: Z = 1 for A = B
    3'b000: ToBranch = (ALUFlags[2] == 1'b1) ? 1'b1 : 1'b0;
    // bne  Z = 0 for A != B
    3'b001: ToBranch = (ALUFlags[2] == 1'b0) ? 1'b1 : 1'b0;
    // blt
    3'b100: ToBranch = L;
    // bge
    3'b101: ToBranch = ~L;
    // bltu
    3'b110: ToBranch = L;
    // bgeu
    3'b111: ToBranch = ~L;
    endcase
end

endmodule
