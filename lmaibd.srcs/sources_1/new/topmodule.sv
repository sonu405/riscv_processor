`timescale 1ns / 1ps

module topmodule(input logic clk, rst);
logic [31:0] pc;
logic [31:0] instruction;

logic [6:0] opcode, funct7;
logic [4:0] rd, rs1, rs2;
logic [31:0] extended_imm;
logic [2:0] funct3;

// register file
logic [31:0] data1, data2;

// ALU
logic [31:0] alu_out, mux_out;

// Mux to Register AT end
logic [31:0] Result;

// CONTROL LOGIC
logic Branch, MemRead, MemWrite, ALUSrc, RegWrite;
logic [1:0] ALUOp, ImmSrc, ResultSrc;
logic [3:0] alu_control_lines;

progcounter pc_uut(.clk(clk), .rst(rst), .pc(pc));

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
control_logic uut_control_unit(.opcode(opcode), .Branch(Branch), .MemRead(MemRead), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .ImmSrc(ImmSrc), .ResultSrc(ResultSrc),
 .ALUOp(ALUOp));
 
// ALU CONTROL
alu_control uut_alu_control(.ALUOp(ALUOp), .funct3(funct3), .funct7(funct7[5]), .alu_control_lines(alu_control_lines));

reg_file uut_regfile(.RegWrite(RegWrite),.clk(clk), .rsW(rd), 
            .rs1(rs1), .rs2(rs2), .dataW(Result), .out1(data1), .out2(data2));

immediate_gen imm_gen_uut(.instr(instruction), .ImmSrc(ImmSrc), .out(extended_imm));

mux uut_mux(.in1(data2), .in2(extended_imm), .BSel(ALUSrc), .out(mux_out));

alu uut_alu(.alu_control_lines(alu_control_lines), .in1(data1), .in2(mux_out), .alu_out(alu_out));

// Data memory
logic [31:0] RD;
datamemory uut_datamem(.clk(clk),.MEMWrite(MemWrite), .mem_addr(alu_out), .WD(data2), .func3(funct3), .RD(RD));

// Result Mux : in2 -- datamemory Read Data
fourby1mux uut_fourby1mux (.in1(alu_out), .in2(RD), .in3(32'b1), .in4(32'b0), .BSel(ResultSrc), .out(Result));
endmodule
