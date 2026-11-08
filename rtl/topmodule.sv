`timescale 1ns / 1ps

`default_nettype none

module topmodule (
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
    input  wire clk,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_HIGH" *)
    input wire rst,

    // Instruction memory BRAM port (core is master)
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM ADDR" *)
    (* X_INTERFACE_MODE = "master" *)
    (* X_INTERFACE_PARAMETER = "MASTER_TYPE BRAM_CTRL" *)
    output logic [31:0] imem_addr,

    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM DIN" *)
    (* X_INTERFACE_MODE = "master" *)
    output logic [31:0] imem_din,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM DOUT" *)
    (* X_INTERFACE_MODE = "master" *)
    input  wire [31:0] imem_dout,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM EN" *)
    (* X_INTERFACE_MODE = "master" *)
    output logic        imem_en,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM WE" *)
    (* X_INTERFACE_MODE = "master" *)
    output logic [3:0]  imem_we,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM RST" *)
    (* X_INTERFACE_MODE = "master" *)
    output logic        imem_rst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM CLK" *)
    (* X_INTERFACE_MODE = "master" *)
    output logic imem_clk,

    // Data memory BRAM port (core is master)
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 DMEM ADDR" *)
    (* X_INTERFACE_PARAMETER = "MASTER_TYPE BRAM_CTRL" *)
    (* X_INTERFACE_MODE = "master" *)

    output logic [31:0] dmem_addr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 DMEM DIN" *)
    (* X_INTERFACE_MODE = "master" *)
    output logic [31:0] dmem_din,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 DMEM DOUT" *)
    (* X_INTERFACE_MODE = "master" *)
    input  wire [31:0] dmem_dout,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 DMEM EN" *)
    (* X_INTERFACE_MODE = "master" *)
    output logic        dmem_en,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 DMEM WE" *)
    (* X_INTERFACE_MODE = "master" *)
    output logic [3:0]  dmem_we,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 DMEM RST" *)
    (* X_INTERFACE_MODE = "master" *)
    output logic        dmem_rst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 DMEM CLK" *)
    (* X_INTERFACE_MODE = "master" *)
    output logic dmem_clk
);

  assign imem_clk = clk;
  assign imem_en  = 1'b1;
  assign imem_we  = 4'b0;  // our instr memory is read-only for the core, so we never write to it.
  assign imem_din = 32'b0;  // no write so no data to input to bram.
  assign imem_rst = 1'b0;

  assign dmem_clk = clk;
  assign dmem_rst = 1'b0;
  assign dmem_en  = 1'b1;  // data memory uses is enabled

  rvcore uut_rvcore (
      .clk(clk),
      .rst(rst),
      .imem_dout(imem_dout),
      .imem_addr(imem_addr),
      .dmem_dout(dmem_dout),
      .dmem_addr(dmem_addr),
      .dmem_we(dmem_we),
      .dmem_din(dmem_din)
  );

endmodule

`default_nettype wire
