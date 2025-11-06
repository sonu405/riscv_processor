`timescale 1ns / 1ps


module progcounter(input logic clk, rst, output logic [31:0] pc);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        pc <= 0;
    end
    else begin
        pc <= pc + 4;
    end
end

endmodule
