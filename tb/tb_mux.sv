`timescale 1ns / 1ps


module tb_mux();
logic [31:0] in1, in2;
logic BSel;
logic [31:0] out;

mux uut(.in1(in1), .in2(in2), .BSel(BSel), .out(out));

initial begin   
    in1 = 10;
    in2 = 20;
    BSel = 0;
    #20 BSel = 1;
end

endmodule
