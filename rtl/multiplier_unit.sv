`timescale 1ns / 1ps

module multiplier_unit(
input logic clk, rst, start,
input logic [31:0] A, B,
input logic [2:0] funct3,
output logic finish,
output logic [31:0] out
);

logic sign;
logic [63:0] booth_out;


always_comb begin
    case (funct3)
    3'b000: begin // mul [31:0]
        sign = 1'b1;
        if (finish) out = booth_out[31:0];
    end
    3'b001: begin // mulh [63:32]
        sign = 1'b1;
        if (finish) out = booth_out[63:32];
    end
    3'b010: begin // mulsu [63:32]
        sign = 1'b0;
        if (finish) out = booth_out[63:32];
    end
    3'b011: begin // mulu [63, 32]
        sign = 1'b0;
        if (finish) out = booth_out[63:32];
    end
    endcase
end

booth_multiplier uut_booth(.clk(clk), .rst(rst),
.start(start), .sign(sign), .Q(A), .M(B), .finish(finish), .out(booth_out));
    
endmodule
