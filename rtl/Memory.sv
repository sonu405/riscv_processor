`timescale 1ns / 1ps

module Memory(
input logic clk, MemWrite, MemRead, 
input logic [2:0] funct3,
input logic [31:0] data2, mem_addr,
output logic [31:0] RD // Read Data
);


// Data memory
datamemory uut_datamem(.clk(clk),.MEMWrite(MemWrite), .MEMRead(MemRead), .mem_addr(mem_addr), .WD(data2), .funct3(funct3), .RD(RD));

endmodule