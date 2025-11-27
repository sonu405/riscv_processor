`timescale 1ns / 1ps

import pipeline_registers::*;

module topmodule(input logic clk, rst);

// PIPELINE REGISTERS
IF_ID if_id;
ID_EX id_ex;
EX_MEM ex_mem;
MEM_WB mem_wb;

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
logic [4:0] rdD, rs1D, rs2D;




// EXECUTE;
logic BranchE, ToBranchE, JumpE;
logic [31:0] PCTargetE, alu_outE, FU_data1, FU_data2;
logic [1:0] ForwardA, ForwardB;
//logic  ALUSrcE, opcode3E, ResultSrcE, MemWriteE, RegWriteE;
//logic [2:0] funct3E;
//logic [3:0] alu_control_linesE;
//logic [4:0] rdE;
//logic [31:0] data1E, data2E, extended_immE, pcE, PCPlus4E;

// MEMORY
//logic MemWriteM, ResultSrcM, RegWriteM; 
//logic [2:0] funct3M;
//logic [4:0] rdM;
//logic [31:0] data2M, mem_addrM, RDM, PCPlus4M, alu_outM;
logic [31:0] RDM;

// WRITEBACK
//logic [1:0] ResultSrcW;
logic RegWriteW;
logic [4:0] rdW;
logic [31:0] ResultW;
//logic [31:0] alu_outW, RDW, PCPlus4W, ResultW;


// FETCH STAGE
Fetch uut_fetch(
    .clk(clk), .rst(rst), .Branch(BranchE), .ToBranch(ToBranchE), .Jump(JumpE),
    .PCTarget(PCTargetE),
    .pc(pcF), .instruction(instructionF), .PCPlus4(PCPlus4F)
);

always_ff @(posedge clk or posedge rst) begin
    if_id.pc <= pcF;
    if_id.instruction <= instructionF;
    if_id.PCPlus4 <= PCPlus4F;
end

// DECODE STAGE
assign PCPlus4D = PCPlus4F;
assign pcD = pcF;
assign instructionD = instructionF;
// rd and Result and RegWrite are already given as input from Writeback stage.

// Control logic
control_logic uut_control_unit(.opcode(opcodeD), .Branch(BranchD), .MemRead(MemReadD),
 .MemWrite(MemWriteD), .ALUSrc(ALUSrcD), .RegWrite(RegWriteD), .ImmSrc(ImmSrcD), 
 .Jump(JumpD), .ResultSrc(ResultSrcD), .ALUOp(ALUOpD));
 
// ALU CONTROL
 alu_control uut_alu_control(.ALUOp(ALUOpD), .funct3(funct3D), .op5(opcodeD[5]), .funct7(funct7D[5]), .alu_control_lines(alu_control_linesD));


Decode uut_decode(
.clk(clk), .RegWrite(RegWriteW),
.ImmSrc(ImmSrcD),
.instruction(if_id.instruction),
.opcode(opcodeD), .funct7(funct7D),
.rdWD(rdW),
.rd(rdD), .rs1(rs1D), .rs2(rs2D),
.data1(data1D), .data2(data2D), .dataW(ResultW), .extended_imm(extended_immD),
.funct3(funct3D)
);

always_ff @(posedge clk or posedge rst) begin
    id_ex.Branch            <= BranchD;
    id_ex.RegWrite          <= RegWriteD;
    id_ex.MemWrite          <= MemWriteD;
    id_ex.ALUSrc            <= ALUSrcD;
    id_ex.Jump              <= JumpD;
    id_ex.opcode3           <= opcodeD[3];
    id_ex.ResultSrc         <= ResultSrcD;
    id_ex.alu_control_lines <= alu_control_linesD;    
    id_ex.funct3            <= funct3D;
    id_ex.rs1               <= rs1D;
    id_ex.rs2               <= rs2D;
    id_ex.rd                <= rdD;
    id_ex.data1             <= data1D;
    id_ex.data2             <= data2D;
    id_ex.extended_imm      <= extended_immD;
    id_ex.PCPlus4           <= if_id.PCPlus4;
    id_ex.pc                <= if_id.pc;
end

// EXECUTE STAGE
// assign ResultSrcE = ResultSrcD; 
// assign rdE = rdD;
// assign PCPlus4E = PCPlus4D;
// assign MemWriteE = MemWriteD;
// assign RegWriteE = RegWriteD;
// assign funct3E = funct3D;
// assign data1E = data1D;
// assign data2E = data2D;
// assign opcode3E = opcodeD[3];
// assign ALUSrcE = ALUSrcD;
// assign extended_immE = extended_immD;
// assign pcE = pcD;
// assign alu_control_linesE = alu_control_linesD;
assign JumpE = id_ex.Jump;
assign BranchE = id_ex.Branch;

// FORWARD UNIT MUX LOGIC
fourby1mux uut_fu_mux1 (.in1(id_ex.data1), .in2(mem_wb.alu_out), .in3(ex_mem.alu_out), .in4(0), .BSel(ForwardA), .out(FU_data1));
fourby1mux uut_fu_mux2 (.in1(id_ex.data2), .in2(mem_wb.alu_out), .in3(ex_mem.alu_out), .in4(0), .BSel(ForwardB), .out(FU_data2));

// FORWARD UNIT MUX LOGIC

Execute uut_execute(
.Jump(id_ex.Jump), .opcode3(id_ex.opcode3), .ALUSrc(id_ex.ALUSrc),
.data1(FU_data1), .data2(FU_data2),
.extended_imm(id_ex.extended_imm), .pc(id_ex.pc),
.funct3(id_ex.funct3),
.alu_control_lines(id_ex.alu_control_lines),
.ToBranch(ToBranchE),
.alu_out(alu_outE), .PCTarget(PCTargetE)
);

always_ff @(posedge clk or posedge rst) begin
    ex_mem.MemWrite  <= id_ex.MemWrite;
    ex_mem.RegWrite  <= id_ex.RegWrite;
    ex_mem.ResultSrc <= id_ex.ResultSrc;
    ex_mem.funct3    <= id_ex.funct3;
    ex_mem.rd        <= id_ex.rd;
//    ex_mem.data2     <= id_ex.data2;
    ex_mem.data2     <= FU_data2;
    ex_mem.alu_out   <= alu_outE;
    ex_mem.PCPlus4   <= id_ex.PCPlus4;
end

// MEMORY STAGE
//assign ResultSrcM = ResultSrcE; 
//assign rdM = rdE;
//assign alu_outM = alu_outE;
//assign PCPlus4M = PCPlus4E;
// assign MemWriteM = MemWriteE;
// assign funct3M = funct3E;
// assign data2M = data2E;
// assign mem_addrM = alu_outE;
// assign RegWriteM = RegWriteE;

Memory uut_memory(.clk(clk), .MemWrite(ex_mem.MemWrite), .funct3(ex_mem.funct3), 
    .data2(ex_mem.data2), .mem_addr(ex_mem.alu_out), .RD(RDM));

always_ff @(posedge clk or posedge rst) begin
    mem_wb.RegWrite  <= ex_mem.RegWrite;
    mem_wb.ResultSrc <= ex_mem.ResultSrc;
    mem_wb.rd        <= ex_mem.rd;
    mem_wb.alu_out   <= ex_mem.alu_out;
    mem_wb.RD        <= RDM;
    mem_wb.PCPlus4   <= ex_mem.PCPlus4;
end

// WRITEBACK STAGE
//assign ResultSrcW = ResultSrcM;
//assign alu_outW = alu_outM;
//assign RDW = RDM;
//assign PCPlus4W = PCPlus4M;
assign rdW = mem_wb.rd;
assign RegWriteW = mem_wb.RegWrite;
Writeback uut_writeback(.ResultSrc(mem_wb.ResultSrc), .alu_out(mem_wb.alu_out), 
    .RD(mem_wb.RD), .PCPlus4(mem_wb.PCPlus4), .Result(ResultW));


// Data Hazard Unit
always_comb begin
    // for data1 of register file
    if ((mem_wb.RegWrite) && (mem_wb.rd != 0) && (id_ex.rs1 == mem_wb.rd)) begin
        ForwardA = 2'b01;
    end
    else if ((ex_mem.RegWrite) && (ex_mem.rd != 0) && (id_ex.rs1 == ex_mem.rd)) begin
        ForwardA = 2'b10;
    end
    else ForwardA = 2'b00;
    
    // for data2 of register file
    if ((mem_wb.RegWrite) && (mem_wb.rd != 0) && (id_ex.rs2 == mem_wb.rd)) begin
        ForwardB = 2'b01;
    end
    else if ((ex_mem.RegWrite) && (ex_mem.rd != 0) && (id_ex.rs2 == ex_mem.rd)) begin
        ForwardB = 2'b10;
    end 
    else ForwardB = 2'b00;
end
endmodule
















