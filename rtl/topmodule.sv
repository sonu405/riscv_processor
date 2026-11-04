`timescale 1ns / 1ps

`default_nettype none

module topmodule (
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
    (* X_INTERFACE_PARAMETER = "FREQ_HZ 100000000" *)
    input logic clk,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_HIGH" *)
    input logic rst,

    // BRAM Port B interface (core is the master)
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM ADDR" *)
    (* X_INTERFACE_MODE = "master" *)
    output logic [31:0] imem_addr, (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM DIN" *)
    output logic [31:0] imem_din, (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM DOUT" *)
    input logic [31:0] imem_dout, (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM EN" *)
    output logic imem_en, (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM WE" *)
    output logic [3:0] imem_we, (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM RST" *)
    output logic imem_rst, (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IMEM CLK" *)
    output logic imem_clk
);

  assign imem_clk = clk;
  assign imem_en  = 1'b1;
  assign imem_we  = 4'b0;  // our instr memory is read-only for the core, so we never write to it.
  assign imem_din = 32'b0;  // no write so no data to input to bram.
  assign imem_rst = 1'b0;

  rvcore uut_rvcore (
      .clk(clk),
      .rst(rst),
      .imem_dout(imem_dout),
      .imem_addr(imem_addr)
  );

endmodule

`default_nettype wire
