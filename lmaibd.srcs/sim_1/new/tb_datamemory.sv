`timescale 1ns / 1ps

module tb_datamemory();
logic [31:0] mem_addr, WD;
logic clk, MEMWrite; 
logic [2:0] func3;
logic [31:0] RD;

datamemory uut_dm(
    .mem_addr(mem_addr), .WD(WD), .clk(clk), 
    .MEMWrite(MEMWrite), .func3(func3), .RD(RD)
);

initial begin
    clk = 0;
    MEMWrite = 0;
    func3 = 3'b100;
    mem_addr=0;
    WD=8'h48;
    forever #10 clk = ~clk;
end 

initial begin
    #10;
    func3 = 3'b000;
    
    #30;
    func3 = 3'b000;
    MEMWrite = 1'b1;
    
    #30;
    MEMWrite = 0;
    func3 = 3'b100;
end

endmodule
