`timescale 1ns / 1ps

module instruction_mem(input logic [31:0] pc, output logic[31:0] instruction);

// PC is 32 bits, so the largest address it can point to is 2^32 -1 -- almost 4GB. 
// For vivado's sake, we'll go with 1KB. 1024
logic [7:0] INST_MEM [1023:0]; 

initial begin
    $readmemh("instruction_mem.mem",INST_MEM);
end

always_comb begin
    instruction = {INST_MEM[pc+3], INST_MEM[pc+2], INST_MEM[pc+1], INST_MEM[pc]};
end

endmodule
