`timescale 1ns / 1ps
import axi_vip_pkg::*;
import tb_bd_axi_vip_0_0_pkg::*;

module tb_bram_test;
  localparam [31:0] BASE = 32'hC000_0000;

  logic clk = 0, resetn = 0;
  logic core_rst = 1;  // core held in reset while program loads
  always #5 clk = ~clk;

  tb_bd_wrapper dut (
      .s_axi_aclk_0(clk),
      .s_axi_aresetn_0(resetn),
      .rst_0(core_rst)
  );

  tb_bd_axi_vip_0_0_mst_t master;

  task automatic axi_write32(input [31:0] addr, input [31:0] data);
    xil_axi_resp_t resp;
    bit [32767:0] wd = data;
    master.AXI4_WRITE_BURST(0, addr, 0, XIL_AXI_SIZE_4BYTE, XIL_AXI_BURST_TYPE_INCR,
                            XIL_AXI_ALOCK_NOLOCK, 0, 0, 0, 0, 0, wd, 0, resp);
  endtask

  initial begin
    master = new("master", dut.tb_bd_i.axi_vip_0.inst.IF);
    master.start_master();

    repeat (10) @(posedge clk);
    resetn = 1;  // release the AXI side only
    repeat (5) @(posedge clk);

    // Load the program (hex!)
    axi_write32(BASE + 0, 32'h00500093);  // addi x1, x0, 5
    axi_write32(BASE + 4, 32'h00300113);  // addi x2, x0, 3
    axi_write32(BASE + 8, 32'h002081B3);  // add  x3, x1, x2
    axi_write32(BASE + 12, 32'h00000013);  // nop

    repeat (5) @(posedge clk);
    core_rst = 0;  // now start the core
    repeat (200) @(posedge clk);

    $display("CORE RAN");
    $finish;
  end
endmodule
