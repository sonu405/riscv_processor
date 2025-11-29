`timescale 1ns / 1ps

module HazardDectectionUnit(
input logic ID_EX_MEMRead, MemWriteD, 
input logic [4:0] rs1D, rs2D, ID_EX_rd,
output logic PCWrite, IF_ID_Write, Stall
);

always_comb begin
    // When the previous instruction (in it's execute stage) was 
    // load and the current instruction has rs1 or rs2 equal to load's rd.
    
    // One exception is when the current instruction is store and previous were load.
    // We don't need stall in this case, because forwarding solves this hazard.
    if (ID_EX_MEMRead && ~(MemWriteD) && (rs1D == ID_EX_rd || rs2D == ID_EX_rd)) begin
        PCWrite = 1'b0;
        IF_ID_Write = 1'b0;
        Stall = 1'b1;
    end
    else begin
        PCWrite = 1'b1;
        IF_ID_Write = 1'b1;
        Stall = 1'b0;
    end
end

endmodule