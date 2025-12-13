`timescale 1ns / 1ps

// TODO: WHY NEED IF_ID_WRITE and ID_EX_WRITE? 
module HazardDectectionUnit(
input logic ID_EX_MEMRead, MemWriteD, BranchE, ToBranchE, JumpE, functional_unit_stall,
input logic [6:0] ID_EX_opcode, ID_EX_funct7,
input logic [4:0] rs1D, rs2D, ID_EX_rd,
output logic PCWrite, IF_ID_Write, StallE, IF_ID_flush, ID_EX_flush, StallD
);

always_comb begin
    // When the previous instruction (in it's execute stage) was 
    // load and the current instruction has rs1 or rs2 equal to load's rd.
    
    // One exception is when the current instruction is store and previous were load.
    // We don't need stall in this case, because forwarding solves this hazard.
    
    // STALLING: if else
    if (ID_EX_MEMRead && ~(MemWriteD) && (rs1D == ID_EX_rd || rs2D == ID_EX_rd)) begin
        PCWrite = 1'b0;
        IF_ID_Write = 1'b0;
        StallD = 1'b1;
        StallE = 1'b0;
    end
    // FOR stall by Functional unit in the Execute stage
    else if (functional_unit_stall) begin
          PCWrite = 1'b0;
          IF_ID_Write = 1'b0;
          StallE = 1'b1;
          StallD = 1'b0;
    end
    else begin
        PCWrite = 1'b1;
        IF_ID_Write = 1'b1;
        StallE = 1'b0;
        StallD = 1'b0;
    end
    
    // FLUSHING IF ELSE 
    // for case: BRANCH NOT TAKEN LOGIC and JUMP
    if ((BranchE && ToBranchE) || JumpE) begin
        IF_ID_flush = 1'b1;
        ID_EX_flush = 1'b1;
    end else begin
        IF_ID_flush = 1'b0;
        ID_EX_flush = 1'b0;
    end
end

endmodule