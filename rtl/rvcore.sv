`timescale 1ns / 1ps

`default_nettype none

module rvcore
  import pipeline_registers::*;
(
    input logic clk,
    input logic rst,

    // Instruction Memory BRAM PORT B Channel
    input  logic [31:0] imem_dout,  // instruction from imemBRAM Port B
    output logic [31:0] imem_addr,  // byte address to imemBRAM Port B

    // Data Memory BRAM PORT B Channel
    input  logic [31:0] dmem_dout,  // data from dmemBRAM Port B
    output logic [ 3:0] dmem_we,    // write enable to dmemBRAM Port B
    output logic [31:0] dmem_addr,  // byte address to dmemBRAM Port B
    output logic [31:0] dmem_din    // data to dmemBRAM Port B
);

  // PIPELINE REGISTERS
  IF_ID  if_id = '0;
  ID_EX  id_ex = '0;
  EX_MEM ex_mem = '0;
  MEM_WB mem_wb = '0;


  logic  IF_ID_flush = 1'b0;
  logic  ID_EX_flush = 1'b0;

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

  // For hazard detection unit
  logic PCWrite, IF_ID_Write, StallE, functional_unit_stall, StallD;


  // EXECUTE;
  logic BranchE, ToBranchE, JumpE;
  logic [31:0] PCTargetE, alu_outE, FU_data1, FU_data2;
  logic [1:0] ForwardA, ForwardB;


  // WRITEBACK
  logic RegWriteW;
  logic [4:0] rdW;
  logic [31:0] ResultW;

  // FETCH STAGE
  Fetch uut_fetch (
      .clk(clk),
      .rst(rst),
      .PCWrite(PCWrite),
      .Branch(BranchE),
      .ToBranch(ToBranchE),
      .Jump(JumpE),
      .PCTarget(PCTargetE),
      .pc(pcF),
      .instruction(instructionF),
      .PCPlus4(PCPlus4F),
      .imem_addr(imem_addr),
      .imem_dout(imem_dout)
  );

  always_ff @(posedge clk or posedge rst) begin
    if (IF_ID_Write) begin
      if (IF_ID_flush) begin
        if_id.pc <= 0;
        if_id.instruction <= 32'h00000013;  // THIS FORMS a nop
        if_id.PCPlus4 <= 0;
      end else begin
        if_id.pc <= pcF;
        if_id.instruction <= instructionF;
        if_id.PCPlus4 <= PCPlus4F;
      end
    end
  end

  // DECODE STAGE
  assign PCPlus4D = PCPlus4F;
  assign pcD = pcF;
  assign instructionD = instructionF;
  // rd and Result and RegWrite are already given as input from Writeback stage.

  // Hazard Detection Unit
  HazardDectectionUnit uut_hdu (
      .ID_EX_MEMRead(id_ex.MemRead),
      .ID_EX_rd(id_ex.rd),
      .rs1D(rs1D),
      .rs2D(rs2D),
      .MemWriteD(MemWriteD),
      .ID_EX_opcode(id_ex.opcode),
      .ID_EX_funct7(id_ex.funct7),
      .ToBranchE(ToBranchE),
      .BranchE(BranchE),
      .JumpE(JumpE),
      .IF_ID_flush(IF_ID_flush),
      .ID_EX_flush(ID_EX_flush),
      .PCWrite(PCWrite),
      .IF_ID_Write(IF_ID_Write),
      .functional_unit_stall(functional_unit_stall),
      .StallD(StallD),
      .StallE(StallE)
  );


  // Control logic
  control_logic uut_control_unit (
      .opcode(opcodeD),
      .Branch(BranchD),
      .MemRead(MemReadD),
      .MemWrite(MemWriteD),
      .ALUSrc(ALUSrcD),
      .RegWrite(RegWriteD),
      .ImmSrc(ImmSrcD),
      .Jump(JumpD),
      .ResultSrc(ResultSrcD),
      .ALUOp(ALUOpD)
  );

  // ALU CONTROL
  alu_control uut_alu_control (
      .ALUOp(ALUOpD),
      .funct3(funct3D),
      .op5(opcodeD[5]),
      .funct7(funct7D[5]),
      .alu_control_lines(alu_control_linesD)
  );


  Decode uut_decode (
      .clk(clk),
      .RegWrite(RegWriteW),
      .ImmSrc(ImmSrcD),
      .instruction(if_id.instruction),
      .opcode(opcodeD),
      .funct7(funct7D),
      .rdWD(rdW),
      .rd(rdD),
      .rs1(rs1D),
      .rs2(rs2D),
      .data1(data1D),
      .data2(data2D),
      .dataW(ResultW),
      .extended_imm(extended_immD),
      .funct3(funct3D)
  );

  always_ff @(posedge clk or posedge rst) begin
    // If the execute stage is stalled then the ID_EX register shouldn't be written.
    if (!StallE) begin
      if (StallD || ID_EX_flush) begin
        // Propagting the stall occured in the decode stage.
        id_ex              <= '0;  // setting everything to zero. Then we unzero the rest.
        id_ex.opcode       <= opcodeD;
        id_ex.funct3       <= funct3D;
        id_ex.funct7       <= funct7D;
        id_ex.rs1          <= rs1D;
        id_ex.rs2          <= rs2D;
        id_ex.rd           <= rdD;
        id_ex.data1        <= data1D;
        id_ex.data2        <= data2D;
        id_ex.extended_imm <= extended_immD;
        id_ex.PCPlus4      <= if_id.PCPlus4;
        id_ex.pc           <= if_id.pc;
      end else begin
        id_ex.Branch            <= BranchD;
        id_ex.RegWrite          <= RegWriteD;
        id_ex.MemWrite          <= MemWriteD;
        id_ex.MemRead           <= MemReadD;
        id_ex.ALUSrc            <= ALUSrcD;
        id_ex.Jump              <= JumpD;
        id_ex.ResultSrc         <= ResultSrcD;
        id_ex.alu_control_lines <= alu_control_linesD;
        id_ex.opcode            <= opcodeD;
        id_ex.funct7            <= funct7D;
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
    end
  end

  // EXECUTE STAGE
  assign JumpE   = id_ex.Jump;
  assign BranchE = id_ex.Branch;

  // FORWARD UNIT MUX LOGIC
  fourby1mux uut_fu_mux1 (
      .in1 (id_ex.data1),
      .in2 (ResultW),
      .in3 (ex_mem.alu_out),
      .in4 (0),
      .BSel(ForwardA),
      .out (FU_data1)
  );
  fourby1mux uut_fu_mux2 (
      .in1 (id_ex.data2),
      .in2 (ResultW),
      .in3 (ex_mem.alu_out),
      .in4 (0),
      .BSel(ForwardB),
      .out (FU_data2)
  );

  // FORWARD UNIT MUX LOGIC
  Execute uut_execute (
      .clk(clk),
      .rst(rst),
      .Jump(id_ex.Jump),
      .opcode(id_ex.opcode),
      .ALUSrc(id_ex.ALUSrc),
      .data1(FU_data1),
      .data2(FU_data2),
      .extended_imm(id_ex.extended_imm),
      .pc(id_ex.pc),
      .funct3(id_ex.funct3),
      .funct7(id_ex.funct7),
      .alu_control_lines(id_ex.alu_control_lines),
      .ToBranch(ToBranchE),
      .functional_unit_stall(functional_unit_stall),
      .execute_out(alu_outE),
      .PCTarget(PCTargetE)
  );

  always_ff @(posedge clk or posedge rst) begin
    if (StallE) begin
      ex_mem         <= '0;  // setting everything to zero. Then we unzero the rest.
      ex_mem.funct3  <= id_ex.funct3;
      ex_mem.rd      <= id_ex.rd;
      ex_mem.opcode  <= id_ex.opcode;
      ex_mem.funct7  <= ex_mem.funct7;
      ex_mem.data2   <= FU_data2;
      ex_mem.alu_out <= alu_outE;
      ex_mem.PCPlus4 <= id_ex.PCPlus4;
      ex_mem.rs2     <= id_ex.rs2;
    end else begin
      ex_mem.MemWrite  <= id_ex.MemWrite;
      ex_mem.MemRead   <= id_ex.MemRead;
      ex_mem.RegWrite  <= id_ex.RegWrite;
      ex_mem.ResultSrc <= id_ex.ResultSrc;
      ex_mem.funct3    <= id_ex.funct3;
      ex_mem.rd        <= id_ex.rd;
      ex_mem.opcode    <= id_ex.opcode;
      ex_mem.funct7    <= ex_mem.funct7;
      ex_mem.data2     <= FU_data2;
      ex_mem.alu_out   <= alu_outE;
      ex_mem.PCPlus4   <= id_ex.PCPlus4;
      ex_mem.rs2       <= id_ex.rs2;
    end
  end

  // MEMORY STAGE
  logic [31:0] store_dataM;

  // WB-to-MEM forward: if the instruction in WB is writing the register that
  // the store in MEM wants to store, take the value from ResultW (this covers
  // load-then-store, where the load data only exists in WB).
  always_comb begin
    if (mem_wb.RegWrite && (mem_wb.rd != 0) && (mem_wb.rd == ex_mem.rs2)) begin
      store_dataM = ResultW;  // ResultW represents the Memory read of the previous instruction.
    end else store_dataM = ex_mem.data2;
  end

  Memory uut_memory (
      .MemWrite(ex_mem.MemWrite),
      .funct3(ex_mem.funct3),
      .data2(store_dataM),
      .mem_addr(ex_mem.alu_out),
      .dmem_we(dmem_we),
      .dmem_din(dmem_din)
  );

  // For RD (read data), the pipeline register is BRAM instead of MEM_WB pipeline register.
  assign dmem_addr = ex_mem.alu_out;

  always_ff @(posedge clk or posedge rst) begin
    // THIS IF IS FUNDAMENTALLY WRONG, STALLING THE WHOLE PIPELINE SO THAT THE
    // FORWARDED DATA ARE AVAILABLE TO THE EXECUTE STAGE WHEN IT IS STALLED.
    //    if (!StallE) begin
    mem_wb.RegWrite  <= ex_mem.RegWrite;
    mem_wb.ResultSrc <= ex_mem.ResultSrc;
    mem_wb.rd        <= ex_mem.rd;
    mem_wb.alu_out   <= ex_mem.alu_out;
    mem_wb.PCPlus4   <= ex_mem.PCPlus4;
    mem_wb.funct3    <= ex_mem.funct3;
    //    end
  end



  // WRITEBACK STAGE
  assign rdW = mem_wb.rd;
  assign RegWriteW = mem_wb.RegWrite;
  Writeback uut_writeback (
      .ResultSrc(mem_wb.ResultSrc),
      .funct3(mem_wb.funct3),
      .alu_out(mem_wb.alu_out),
      .RD(dmem_dout),  // Output from pipeline register for RD_M (DMEM BRAM)
      .PCPlus4(mem_wb.PCPlus4),
      .Result(ResultW)  // the lw also comes from here
  );


  // Data Hazard Unit
  always_comb begin
    // --- FOR DATA FORWARDING BASED ON source and destination registers
    // data1
    if (ex_mem.RegWrite && ex_mem.rd != 0 && id_ex.rs1 == ex_mem.rd) ForwardA = 2'b10;
    else if (mem_wb.RegWrite && mem_wb.rd != 0 && id_ex.rs1 == mem_wb.rd) ForwardA = 2'b01;
    else ForwardA = 2'b00;

    // data2
    if (ex_mem.RegWrite && ex_mem.rd != 0 && id_ex.rs2 == ex_mem.rd) ForwardB = 2'b10;
    else if (mem_wb.RegWrite && mem_wb.rd != 0 && id_ex.rs2 == mem_wb.rd) ForwardB = 2'b01;
    else ForwardB = 2'b00;
  end
endmodule

`default_nettype wire
