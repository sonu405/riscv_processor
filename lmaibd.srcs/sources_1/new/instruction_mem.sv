`timescale 1ns / 1ps

module instruction_mem(input logic [31:0] pc, output logic[31:0] instruction);

logic [7:0] INST_MEM [23:0]; // for 5 instructions of 32 bits.

initial begin
    $readmemh("instruction_mem.mem",INST_MEM);
end

always_comb begin
    instruction = {INST_MEM[pc+3], INST_MEM[pc+2], INST_MEM[pc+1], INST_MEM[pc]};
end

endmodule
