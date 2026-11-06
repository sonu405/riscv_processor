`timescale 1ns / 1ps

module datamemory (
    input logic MEMWrite,
    input logic [2:0] funct3,
    input logic [31:0] mem_addr,
    input logic [31:0] WD,
    output logic [3:0] dmem_we,
    output logic [31:0] dmem_din
);

  //   always_comb begin
  //     if (MEMRead) begin
  //       case (funct3)
  //         3'b000: begin
  //           RD = {{24{MEM[mem_addr][7]}}, MEM[mem_addr]};
  //         end
  //         3'b001: begin
  //           RD = {{16{MEM[mem_addr][7]}}, MEM[mem_addr+1], MEM[mem_addr]};
  //         end
  //         3'b010: begin
  //           RD = {MEM[mem_addr+3], MEM[mem_addr+2], MEM[mem_addr+1], MEM[mem_addr]};
  //         end
  //         3'b100: begin
  //           RD = {{24{1'b0}}, MEM[mem_addr]};
  //         end
  //         3'b101: begin
  //           RD = {{16{1'b0}}, MEM[mem_addr+1], MEM[mem_addr]};
  //         end
  //       endcase
  //     end
  //   end


endmodule
