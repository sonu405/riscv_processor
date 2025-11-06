`timescale 1ns / 1ps

module alu_control(
    input logic [1:0] ALUOp,
    input logic [2:0] funct3,
    input logic funct7,
    output logic [3:0] alu_control_lines
);

always_comb begin
    case (ALUOp) 
        2'b00: begin
            alu_control_lines = 4'b0010;
        end
        2'b01: begin
            alu_control_lines = 4'b0110;
        end
        2'b10: begin
            case (funct3)
                3'b000: begin
                    if (funct7) alu_control_lines = 4'b0110;
                    else alu_control_lines = 4'b0010;
                    
                end
                3'b110: begin
                    alu_control_lines = 4'b0001;
                end
                3'b111: begin
                    alu_control_lines = 4'b0000;
                end
            endcase
        end
    endcase
end

endmodule
