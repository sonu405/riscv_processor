`timescale 1ns / 1ps

module tb_inst_mem();

logic [31:0] pc;
logic [31:0] instruction;
instruction_mem uut(.pc(pc), .instruction(instruction));

initial begin
    pc = 0;
    #10 pc = 4;
end
endmodule
