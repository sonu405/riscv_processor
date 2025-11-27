THIS IS THE IMPLEMENTATION OF RISC V PROCESSOR.

# Objectives
1. Implement forwarding unit
	- load followed by store. or vice versa(Elaboaration on pg 302, H&P)
	- an instruction with rs same as rd in the previous instruction when the previous instruction is load store.
	This is unlike the previous case because in the previous case, in such a case, the subsequent instruction 
	would take it's value from the EX_MEM register but in the case of load, the value can only be taken 
	from load


Line 146, that funcking asshole is supposed to store the data selected by the FORWARD UNIT MULTIPLEXER AND NOT SIMLY DATA2.
ALSO, HANDLE THE CASE OF MULTIMLE DEPENDENCY THAT IS THE sw INSTRUCTION HAS x5 and x19 as rs1 and rs2 and both 
these rs1 and rs2 are forwarded from previous instructions.
Test Code:

addi x1, x0, 5        # x1 = 5  -- 93 00 50 00
addi x2, x0, 10       # x2 = 10 -- 13 01 A0 00
addi x19, x0, 100     # x19 = memory address base -- 93 09 40 06
addi x5, x1, 2                    -- 93 82 20 00
sw   x5, 0(x19)       # store x5  -- 23 A0 59 00
addi x21, x0, 0       # spacing  -- 93 0A 00 00
addi x21, x0, 0       # spacing  -- 93 0A 00 00
lw   x22, 0(x19)      # load back into x22 -- 03 AB 09 00

MAJOR PROBLEM IS DOUBLE DEPENDENCY OF SW ON BOTH forwarding from addi of x5 and x19 of addi before it.

# Instructions Tested
1. lw
2. sw
3. addi
4. add


`timescale 1ns / 1ps

module Execute(
input logic Jump, opcode3, ALUSrc,
input logic [31:0] data1, data2, EX_MEM_alu_out, MEM_WB_alu_out, extended_imm, pc,
input logic [1:0] ForwardA, ForwardB,
input logic [2:0] funct3,
input logic [3:0] alu_control_lines,
output logic ToBranch,
output logic [31:0] alu_out, PCTarget
);

logic [31:0] PCTargetAdderInput, mux_out;
logic [3:0] ALUFlags; // N, Z, C, V
logic [31:0] FU_data1, FU_data2; // output of forward unit multiplexers

// FORWARD UNIT LOGIC 
fourby1mux uut_fu_mux1 (.in1(data1), .in2(MEM_WB_alu_out), .in3(EX_MEM_alu_out), .in4(0), .BSel(ForwardA), .out(FU_data1));
fourby1mux uut_fu_mux2 (.in1(data2), .in2(MEM_WB_alu_out), .in3(EX_MEM_alu_out), .in4(0), .BSel(ForwardB), .out(FU_data2));


// FORWARD UNIT LOGIC END

// deciding either to do PC + imm or data1 + imm.
// data1 comes from register file. Note that, we only select data1 for jalr instruction.
// Note: opcode3 means opcode[3]
mux uut_mux4(.in1(pc), .in2(FU_data1), .BSel(Jump & (~opcode3)), .out(PCTargetAdderInput));

// calculating PCTarget for jalr, jalr and branch
adder uut_add2(.in1(extended_imm), .in2(PCTargetAdderInput), .out(PCTarget)); // calculates PCTarget for B and J type instructions

mux uut_mux1(.in1(FU_data2), .in2(extended_imm), .BSel(ALUSrc), .out(mux_out));

// EXECUTE Stage
alu uut_alu(.alu_control_lines(alu_control_lines), .in1(FU_data1), .in2(mux_out), .alu_out(alu_out), .ALUFlags(ALUFlags));

BranchUnit uut_branch(.ALUFlags(ALUFlags), .funct3(funct3), .ToBranch(ToBranch));

endmodule






