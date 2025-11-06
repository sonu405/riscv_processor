`timescale 1ns / 1ps

module control_logic(
input logic [6:0] opcode,
output logic Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
output logic [1:0] ALUOp);

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
        end
        7'b0010011: begin
            RegWrite = 1;
            ALUSrc = 1;
            MemRead = 0;
            MemWrite = 0;
            MemtoReg = 0;
            Branch = 0;
            ALUOp = 2'b10;
        end
        7'b0000011: begin
            RegWrite = 1;
            ALUSrc = 1;
            MemRead = 1;
            MemWrite = 0;
            MemtoReg = 1;
            Branch = 0;
            ALUOp = 2'b00;
        end
        7'b0100011: begin
            RegWrite = 0;
            ALUSrc = 1;
            MemRead = 0;
            MemWrite = 1;
            MemtoReg = 0;
            Branch = 0;
            ALUOp = 2'b00;
        end
        7'b1100011: begin
            RegWrite = 0;
            ALUSrc = 0;
            MemRead = 0;
            MemWrite = 0;
            MemtoReg = 0;
            Branch = 1;
            ALUOp = 2'b01;
        end        
    endcase
end
endmodule



