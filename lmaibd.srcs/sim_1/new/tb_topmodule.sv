`timescale 1ns / 1ps

module tb_topmodule();

logic clk, rst;

topmodule uut_top(.clk(clk), .rst(rst));

initial begin
    rst = 1;
    clk = 0;
    forever #10 clk = !clk;
end

initial begin
    #10 rst = 0;
end

endmodule