`timescale 1ns / 1ps

module topmodule(input logic clk, rst);
logic [31:0] PCNext, pc, PCTarget, PCPlus4;
logic [31:0] instruction;

logic [6:0] opcode, funct7;
logic [4:0] rd, rs1, rs2;
logic [31:0] extended_imm;
logic [2:0] funct3;

// register file
logic [31:0] data1, data2;

// ALU
logic Zero;
logic [31:0] alu_out, mux_out;

// Mux to Register AT end
logic [31:0] Result;

// CONTROL LOGIC
logic Branch, MemRead, MemWrite, ALUSrc, RegWrite, PCSrc;
logic [1:0] ALUOp, ImmSrc, ResultSrc;
logic [3:0] alu_control_lines;

// Program Counter 
adder uut_add1(.in1(pc), .in2(4), .out(PCPlus4)); // adder for => PC + 4
adder uut_add2(.in1(pc), .in2(extended_imm), .out(PCTarget)); // calculates PCTarget for B and J type instructions

mux uut_mux2(.in1(PCPlus4), .in2(PCTarget), .BSel(PCSrc), .out(PCNext));

progcounter pc_uut(.clk(clk), .rst(rst), .PCNext(PCNext),.pc(pc));

// Instruction memory
instruction_mem inst_uut(.pc(pc), .instruction(instruction));

always_comb begin
    // Immediate is splitted by extend unit based on the signal by control unit.
    opcode = instruction[6:0];      // 7 bits
    rd = instruction[11:7];         // 5 bits
    funct3 = instruction[14:12];    // 3 bits 
    rs1 = instruction[19:15];       // 5 bits
    rs2 = instruction[24:20];       // 5 bits
    funct7 = instruction[31:25];    // 7 bits 
end

// CONTROL LOGIC
control_logic uut_control_unit(.opcode(opcode), .Zero(Zero), .Branch(Branch), .MemRead(MemRead),
 .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .ImmSrc(ImmSrc), 
 .PCSrc(PCSrc), .ResultSrc(ResultSrc), .ALUOp(ALUOp));
 
// ALU CONTROL
alu_control uut_alu_control(.ALUOp(ALUOp), .funct3(funct3), .funct7(funct7[5]), .alu_control_lines(alu_control_lines));

reg_file uut_regfile(.RegWrite(RegWrite),.clk(clk), .rsW(rd), 
            .rs1(rs1), .rs2(rs2), .dataW(Result), .out1(data1), .out2(data2));

immediate_gen imm_gen_uut(.instr(instruction), .ImmSrc(ImmSrc), .out(extended_imm));

mux uut_mux1(.in1(data2), .in2(extended_imm), .BSel(ALUSrc), .out(mux_out));

alu uut_alu(.alu_control_lines(alu_control_lines), .in1(data1), .in2(mux_out), .alu_out(alu_out), .Zero(Zero));


// Data memory
logic [31:0] RD;
datamemory uut_datamem(.clk(clk),.MEMWrite(MemWrite), .mem_addr(alu_out), .WD(data2), .func3(funct3), .RD(RD));

// Result Mux: choose the input that is written into the register file
// in1 -- alu_out
// in2 -- Data read by data memory
// in3 -- PC + 4 -- for jump instruction's rd field
fourby1mux uut_fourby1mux (.in1(alu_out), .in2(RD), .in3(PCPlus4), .in4(32'b0), .BSel(ResultSrc), .out(Result));
endmodule
