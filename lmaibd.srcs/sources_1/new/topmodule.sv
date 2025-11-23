`timescale 1ns / 1ps

module topmodule(input logic clk, rst);
// LOGIC SIGNALS DEFINED

// FETCH;
logic [31:0] pcF, instructionF, PCPlus4F;

// Decode Stage
logic BranchD, MemReadD, MemWriteD, ALUSrcD, RegWriteD, JumpD;
logic [1:0] ALUOpD, ImmSrcD, ResultSrcD;
logic [3:0] alu_control_linesD;
logic [6:0] opcodeD, funct7D;
logic [2:0] funct3D;
logic [31:0] data1D, data2D, extended_immD, instructionD, PCPlus4D, pcD, ResultD;
logic [4:0] rdD;

// EXECUTE;
logic BranchE, ToBranchE, JumpE, ALUSrcE, opcode3E, ResultSrcE, MemWriteE;
logic [2:0] funct3E;
logic [3:0] alu_control_linesE;
logic [4:0] rdE;
logic [31:0] PCTargetE, data1E, data2E, extended_immE, pcE, alu_outE, PCPlus4E;

// MEMORY
logic MemWriteM, ResultSrcM; 
logic [2:0] funct3M;
logic [4:0] rdM;
logic [31:0] data2M, mem_addrM, RDM, PCPlus4M, alu_outM;

// WRITEBACK
logic [1:0] ResultSrcW;
logic [4:0] rdW;
logic [31:0] alu_outW, RDW, PCPlus4W, ResultW;

// ALU CONTROL
alu_control uut_alu_control(.ALUOp(ALUOpD), .funct3(funct3D), .op5(opcodeD[5]), .funct7(funct7D[5]), .alu_control_lines(alu_control_linesD));


// FETCH STAGE
Fetch uut_fetch(
    .clk(clk), .rst(rst), .Branch(BranchE), .ToBranch(ToBranchE), .Jump(JumpE),
    .PCTarget(PCTargetE),
    .pc(pcF), .instruction(instructionF), .PCPlus4(PCPlus4F)
);

// DECODE STAGE
assign PCPlus4D = PCPlus4F;
assign pcD = pcF;
assign instructionD = instructionF;
assign ResultD = ResultW;
// rd and Result are already given as input from Writeback stage.

// Control logic
control_logic uut_control_unit(.opcode(opcodeD), .Branch(BranchD), .MemRead(MemReadD),
 .MemWrite(MemWriteD), .ALUSrc(ALUSrcD), .RegWrite(RegWriteD), .ImmSrc(ImmSrcD), 
 .Jump(JumpD), .ResultSrc(ResultSrcD), .ALUOp(ALUOpD));
 

Decode uut_decode(
.clk(clk), .RegWrite(RegWriteD),
.ImmSrc(ImmSrcD),
.instruction(instructionD),
.opcode(opcodeD), .funct7(funct7D),
.rdWD(rdW),
.rd(rdD),
.data1(data1D), .data2(data2D), .dataW(ResultD), .extended_imm(extended_immD),
.funct3(funct3D)
);

// EXECUTE STAGE
assign ResultSrcE = ResultSrcD; 
assign rdE = rdD;
assign PCPlus4E = PCPlus4D;
assign MemWriteE = MemWriteD;
assign funct3E = funct3D;
assign data1E = data1D;
assign data2E = data2D;
assign JumpE = JumpD;
assign BranchE = BranchD;
assign opcode3E = opcodeD[3];
assign ALUSrcE = ALUSrcD;
assign extended_immE = extended_immD;
assign pcE = pcD;
assign alu_control_linesE = alu_control_linesD;

Execute uut_execute(
.Jump(JumpE), .opcode3(opcode3E), .ALUSrc(ALUSrcE),
.data1(data1E), .data2(data2E), .extended_imm(extended_immE), .pc(pcE),
.funct3(funct3E),
.alu_control_lines(alu_control_linesE),
.ToBranch(ToBranchE),
.alu_out(alu_outE), .PCTarget(PCTargetE)
);

// MEMORY STAGE
assign ResultSrcM = ResultSrcE; 
assign rdM = rdE;
assign alu_outM = alu_outE;
assign PCPlus4M = PCPlus4E;
assign MemWriteM = MemWriteE;
assign funct3M = funct3E;
assign data2M = data2E;
assign mem_addrM = alu_outE;

Memory uut_memory(.clk(clk), .MemWrite(MemWriteM), .funct3(funct3M), .data2(data2M), .mem_addr(mem_addrM), .RD(RDM));

// WRITEBACK STAGE
assign ResultSrcW = ResultSrcM;
assign rdW = rdM;
assign alu_outW = alu_outM;
assign RDW = RDM;
assign PCPlus4W = PCPlus4M;
Writeback uut_writeback(.ResultSrc(ResultSrcW), .alu_out(alu_outW), .RD(RDW), .PCPlus4(PCPlus4W), .Result(ResultW));

endmodule