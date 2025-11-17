`timescale 1ns / 1ps


module alu(
input logic [3:0] alu_control_lines, 
input logic [31:0] in1, in2,
output logic [31:0] alu_out,
output logic [3:0] ALUFlags // N, Z, C, V
);

always_comb begin
    ALUFlags = 4'b0000; // Default value


    case (alu_control_lines)
        4'b0000: alu_out = in1 & in2;
        4'b0001: alu_out = in1 | in2;
        // ALUFlags[2] is carryout
//        4'b0010: {ALUFlags[1], alu_out} = in1 + in2; 
//        4'b0110: {ALUFlags[1], alu_out} = in1 - in2;
        4'b0010: alu_out = in1 + in2; 
        4'b0110: alu_out = in1 - in2;
        default: alu_out = 32'b0;
    endcase
    

    ALUFlags[2] = (alu_out == 32'b0); // Zero flag
    
    ALUFlags[3] = alu_out[31]; // negative bit (MSB = 1)
        
    // Overflow flag
    ALUFlags[0] = 
    // A and sum have opposite signs
    (in1[31] ^ alu_out[31])
    // A and B have same signs while addition (control_1 = 0) or 
    // A and B have opp signs when subtraction (control_1 = 1)
    // (or in other words when A and ~B have same sign when subtraction.
    & ~(in1[31] ^ in2[31] ^ alu_control_lines[1]) 
    & (alu_control_lines[2]); // alu performing add or subtract;
end

endmodule
