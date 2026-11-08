`timescale 1ns / 1ps

`default_nettype none

module Memory (
    input wire MemWrite,
    input wire [2:0] funct3,
    input wire [31:0] data2,  // data to write to memory (from rs2)
    input wire [31:0] mem_addr,
    output logic [31:0] RD,  // Read Data

    output logic [ 3:0] dmem_we,
    output logic [31:0] dmem_din
);

  // For SW
  always_comb begin
    // default
    dmem_we  = 4'b0;
    dmem_din = 32'b0;

    /*
    The BRAM is word addressable, so it ignores mem_addr[1:0]. We use those two
    bits to choose which byte lane(s) of the word to write, via the byte write
    enables (dmem_we) and by shifting the store data into the matching lane(s).
    */

    if (MemWrite) begin
      case (funct3)
        3'b000: begin  // sb
          dmem_we  = 4'b0001 << mem_addr[1:0];
          dmem_din = {24'b0, data2[7:0]} << (8 * mem_addr[1:0]);
        end
        3'b001: begin  // sh
          dmem_we  = 4'b0011 << mem_addr[1:0];
          dmem_din = {16'b0, data2[15:0]} << (8 * mem_addr[1:0]);
        end
        3'b010: begin  // sw
          dmem_we  = 4'b1111;
          dmem_din = data2;
        end
      endcase
    end
  end

endmodule

`default_nettype wire
