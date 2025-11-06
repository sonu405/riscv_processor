`timescale 1ns / 1ps

module control_logic(
input logic [6:0] opcode,
output logic Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
output logic [1:0] ALUOp, ImmSrc, ResultSrc);

always_comb begin
    case (opcode)
        7'b0110011: begin
            RegWrite = 1;
            ALUSrc = 0;
            MemRead = 0;
            MemWrite = 0;
            MemtoReg = 0;
            Branch = 0;
            ALUOp = 2'b10;
            ImmSrc = 0; // Don't Care
            ResultSrc = 2'b00;
        end
        7'b0010011: begin // I type other than load
            RegWrite = 1;
            ALUSrc = 1;
            MemRead = 0;
            MemWrite = 0;
            MemtoReg = 0;
            Branch = 0;
            ALUOp = 2'b10;
            ImmSrc = 2'b00;
            ResultSrc = 2'b00; // Write alu out to register file
        end
        7'b0000011: begin   // I type -- load instructions
            RegWrite = 1;
            ALUSrc = 1;
            MemRead = 1;
            MemWrite = 0;
            MemtoReg = 1;
            Branch = 0;
            ALUOp = 2'b00;
            ImmSrc = 2'b00;
            ResultSrc = 2'b01; // write memory to register file
        end
        7'b0100011: begin  // S TYPE
            RegWrite = 0;
            ALUSrc = 1;
            MemRead = 0;
            MemWrite = 1;
            MemtoReg = 0;
            Branch = 0;
            ALUOp = 2'b00;
            ImmSrc = 2'b01; 
            ResultSrc = 2'b00; // Don't care, we set to 0
        end
        7'b1100011: begin   // B type
            RegWrite = 0;
            ALUSrc = 0;
            MemRead = 0;
            MemWrite = 0;
            MemtoReg = 0;
            Branch = 1;
            ALUOp = 2'b01;
            ImmSrc = 2'b10;
            ResultSrc = 2'b00; // DON't care
        end        
        // EXTEND FOR J TYPE AND MAKE IMMSRC 11
    endcase
end
endmodule



