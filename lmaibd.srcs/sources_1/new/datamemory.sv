`timescale 1ns / 1ps

module datamemory(
input logic [31:0] mem_addr, WD,
input logic clk, MEMWrite, 
input logic [2:0] func3,
output logic [31:0] RD
);

logic [7:0] MEM [0:1001];

initial begin
    $readmemh("datamemory.mem", MEM);
end

// FOR SW
always_ff@(posedge clk) begin
    if (MEMWrite) begin
    case (func3)
    3'b000:begin
        MEM[mem_addr] = WD[7:0];
    end
    3'b001:begin
        // Following Little Endian
        MEM[mem_addr] = WD[15:8];
        MEM[mem_addr + 1] = WD[7:0];
    end
    3'b010: begin
        // 0x44556677
        // mem_addr     -> 77   [7:0]
        // mem_addr + 1 -> 66
        MEM[mem_addr] = WD[7:0];
        MEM[mem_addr + 1] = WD[15:8];
        MEM[mem_addr + 2] = WD[23:16];
        MEM[mem_addr + 3] = WD[31:24];
    end
    endcase
    end
end

always_comb begin
    case (func3)
    3'b000:begin 
        RD = {{24{MEM[mem_addr][7]}}, MEM[mem_addr]};
    end
    3'b001:begin
        RD = {{16{MEM[mem_addr][7]}},MEM[mem_addr+1],MEM[mem_addr]};
    end
    3'b010: begin
        RD = {MEM[mem_addr+3], MEM[mem_addr+2],MEM[mem_addr+1],MEM[mem_addr]};
    end
    3'b100: begin
        RD = {{24{1'b0}},MEM[mem_addr]};
    end
    3'b101: begin
        RD = {{16{1'b0}},MEM[mem_addr+1],MEM[mem_addr]};
    end
    endcase 
end


endmodule
