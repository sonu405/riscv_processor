`timescale 1ns / 1ps

module control_logic (
    input wire [6:0] opcode,
    output logic Branch,
    output logic MemRead,
    output logic MemWrite,
    output logic ALUSrc,
    output logic RegWrite,
    output logic Jump,
    output logic [1:0] ALUOp,
    output logic [2:0] ImmSrc,
    output logic [1:0] ResultSrc
);

  always_comb begin
    Branch = 0;
    MemRead = 0;
    MemWrite = 0;
    ALUSrc = 0;
    RegWrite = 0;
    Jump = 0;
    ResultSrc = 0;
    ALUOp = 0;
    ImmSrc = 0;

    // TODO: REMOVE MemRead after confirmation
    // ResultSrc replaces MemToReg
    case (opcode)  // R type
      7'b0110011: begin
        RegWrite = 1;
        ALUSrc = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 2'b10;
        ImmSrc = 3'b000;  // Don't Care
        ResultSrc = 2'b00;
        Jump = 0;
      end
      7'b0010011: begin  // I type other than load and jalr
        RegWrite = 1;
        ALUSrc = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 2'b10;
        ImmSrc = 3'b000;  // Don't Care
        ResultSrc = 2'b00;  // Write alu out to register file
        Jump = 0;
      end
      7'b0000011: begin  // I type -- load instructions
        RegWrite = 1;
        ALUSrc = 1;
        MemRead = 1;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 2'b00;
        ImmSrc = 3'b000;
        ResultSrc = 2'b01;  // write memory to register file
        Jump = 1'b0;
      end
      7'b1100111: begin  // I type -- Jump and Link Register
        RegWrite = 1;
        ALUSrc = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 2'b00;  // ADD
        ImmSrc = 3'b000;
        ResultSrc = 2'b10;  // write PC+4 to register file
        Jump = 1;
      end
      7'b0100011: begin  // S TYPE
        RegWrite = 0;
        ALUSrc = 1;
        MemRead = 0;
        MemWrite = 1;
        Branch = 0;
        ALUOp = 2'b00;
        ImmSrc = 3'b001;
        ResultSrc = 2'b00;  // Don't care, we set to 0
        Jump = 0;
      end
      7'b1100011: begin  // B type -- do A - B whenever Branch
        RegWrite = 0;
        ALUSrc = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        ALUOp = 2'b01;
        ImmSrc = 3'b010;
        ResultSrc = 2'b00;  // DON't care
        Jump = 0;
      end
      7'b1101111: begin  // J Type
        RegWrite  = 1;  // We write PC+4 to register file
        ALUSrc    = 0;
        MemRead   = 0;
        MemWrite  = 0;
        Branch    = 0;
        ALUOp     = 2'b00;  // we don't use alu
        ImmSrc    = 3'b011;
        ResultSrc = 2'b10;  // write PC+4 to register file
        Jump      = 1;
      end
      7'b0110111: begin  // U Type -- lui
        RegWrite  = 1;
        ALUSrc    = 1;
        MemRead   = 0;
        MemWrite  = 0;
        Branch    = 0;
        ALUOp     = 2'b00;  // add
        ImmSrc    = 3'b100;
        ResultSrc = 2'b00;
        Jump      = 0;
      end
      7'b0010111: begin  // U Type -- auipc
        RegWrite  = 1;
        ALUSrc    = 1;
        MemRead   = 0;
        MemWrite  = 0;
        Branch    = 0;
        ALUOp     = 2'b00;  // add
        ImmSrc    = 3'b100;
        ResultSrc = 2'b00;
        Jump      = 0;
      end
    endcase
  end
endmodule



