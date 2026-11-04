`timescale 1ns / 1ps

module reg_file(
    input logic RegWrite, clk,
    input logic [4:0] rsW, rs1, rs2,
    input logic [31:0] dataW,
    output logic [31:0] out1, out2
);

logic [31:0] REG_FILE[31:0];

initial begin
    $readmemh("reg_file.mem",REG_FILE);
end

always_comb begin
    if (rsW == rs1 && rsW != 0) out1 = dataW;
    else  out1 = REG_FILE[rs1];
    
    if (rsW == rs2 && rsW != 0) out2 = dataW;
    else out2 = REG_FILE[rs2];
end

always_ff @(posedge clk) begin
    if (RegWrite && rsW != 0) begin
        REG_FILE[rsW] <= dataW;
    end
end


endmodule
