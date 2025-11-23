`timescale 1ns / 1ps

module control_logic(
input logic [6:0] opcode,
output logic Branch, MemRead, MemWrite, ALUSrc, RegWrite, Jump, 
output logic [1:0] ALUOp, ImmSrc, ResultSrc);
// TODO: REMOVE MemRead after confirmation
// ResultSrc replaces MemToReg

always_comb begin
    case (opcode)        // R type
        7'b0110011: begin
            RegWrite = 1;
            ALUSrc = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b10;
            ImmSrc = 0; // Don't Care
            ResultSrc = 2'b00;
            Jump = 0;
        end
        7'b0010011: begin // I type other than load and jalr
            RegWrite = 1;
            ALUSrc = 1;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b10;
            ImmSrc = 2'b00;
            ResultSrc = 2'b00; // Write alu out to register file
            Jump = 0;
        end
        7'b0000011: begin   // I type -- load instructions
            RegWrite = 1;
            ALUSrc = 1;
            MemRead = 1;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b00;
            ImmSrc = 2'b00;
            ResultSrc = 2'b01; // write memory to register file
            Jump = 1'b0;
        end
        7'b1100111: begin   // I type -- Jump and Link Register
            RegWrite = 1;
            ALUSrc = 1;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b00;  // ADD
            ImmSrc = 2'b00;
            ResultSrc = 2'b10; // write PC+4 to register file
            Jump = 1;            
        end
        7'b0100011: begin  // S TYPE
            RegWrite = 0;
            ALUSrc = 1;
            MemRead = 0;
            MemWrite = 1;
            Branch = 0;
            ALUOp = 2'b00;
            ImmSrc = 2'b01; 
            ResultSrc = 2'b00; // Don't care, we set to 0
            Jump = 0;
        end
        7'b1100011: begin   // B type
            RegWrite = 0;
            ALUSrc = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 1;
            ALUOp = 2'b01;
            ImmSrc = 2'b10;
            ResultSrc = 2'b00; // DON't care
            Jump = 0;
        end
        7'b1101111:begin       // J Type
            RegWrite = 1;      // We write PC+4 to register file
            ALUSrc = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;  
            ALUOp = 2'b00;     // we don't use alu
            ImmSrc = 2'b11;
            ResultSrc = 2'b10; // write PC+4 to register file
            Jump = 1;
        end        
    endcase
end
endmodule



