// `timescale 1ns / 1ps
// import axi_vip_pkg::*;
// import tb_bd_axi_vip_0_0_pkg::*;

// module tb_bram_test;
//   localparam [31:0] BASE = 32'hC000_0000;

//   logic clk = 0, resetn = 0;
//   logic core_rst = 1;  // core held in reset while program loads
//   always #5 clk = ~clk;

//   tb_bd_wrapper dut (
//       .s_axi_aclk_0(clk),
//       .s_axi_aresetn_0(resetn),
//       .rst_0(core_rst)
//   );

//   tb_bd_axi_vip_0_0_mst_t master;

//   task automatic axi_write32(input [31:0] addr, input [31:0] data);
//     xil_axi_resp_t resp;
//     bit [32767:0] wd = data;
//     master.AXI4_WRITE_BURST(0, addr, 0, XIL_AXI_SIZE_4BYTE, XIL_AXI_BURST_TYPE_INCR,
//                             XIL_AXI_ALOCK_NOLOCK, 0, 0, 0, 0, 0, wd, 0, resp);
//   endtask

//   initial begin
//     master = new("master", dut.tb_bd_i.axi_vip_0.inst.IF);
//     master.start_master();

//     repeat (10) @(posedge clk);
//     resetn = 1;  // release the AXI side only
//     repeat (5) @(posedge clk);

//     // Load the program (hex!)
//     axi_write32(BASE + 0, 32'h00500093);  // addi x1, x0, 5
//     axi_write32(BASE + 4, 32'h00300113);  // addi x2, x0, 3
//     axi_write32(BASE + 8, 32'h002081B3);  // add  x3, x1, x2
//     axi_write32(BASE + 12, 32'h00000013);  // nop

//     repeat (5) @(posedge clk);
//     core_rst = 0;  // now start the core
//     repeat (200) @(posedge clk);

//     $display("CORE RAN");
//     $finish;
//   end
// endmodule

`timescale 1ns / 1ps
import axi_vip_pkg::*;
import tb_bd_axi_vip_0_0_pkg::*;

// SIMULATION ONLY. Self-checking test for the RV32I core through the AXI VIP.
// Program is hand-assembled and cross-checked on an independent RV32 emulator.
module tb_bram_test;
  localparam logic [31:0] IMEM_BASE = 32'hC000_8000;
  localparam logic [31:0] DMEM_BASE = 32'hC200_0000;  // must match the Address Editor

  logic clk = 0, resetn = 0;
  logic core_rst = 1;  // core held in reset while memories load
  always #5 clk = ~clk;

  tb_bd_wrapper dut (
      .s_axi_aclk_0(clk),
      .s_axi_aresetn_0(resetn),
      .rst_0(core_rst)
  );

  tb_bd_axi_vip_0_0_mst_t master;
  int unsigned errors = 0;

  task automatic axi_write32(input [31:0] addr, input [31:0] data);
    xil_axi_resp_t resp;
    bit [32767:0] wd = data;
    master.AXI4_WRITE_BURST(0, addr, 0, XIL_AXI_SIZE_4BYTE, XIL_AXI_BURST_TYPE_INCR,
                            XIL_AXI_ALOCK_NOLOCK, 0, 0, 0, 0, 0, wd, 0, resp);
  endtask

  // Read-side argument order is from memory of PG267:
  // (id, addr, len, size, burst, lock, cache, prot, region, qos, aruser, data, resp, ruser)
  task automatic axi_read32(input [31:0] addr, output [31:0] data);
    xil_axi_resp_t resp;
    bit [32767:0] rd;
    bit [31:0] ruser;
    master.AXI4_READ_BURST(0, addr, 0, XIL_AXI_SIZE_4BYTE, XIL_AXI_BURST_TYPE_INCR,
                           XIL_AXI_ALOCK_NOLOCK, 0, 0, 0, 0, 0, rd, resp, ruser);
    data = rd[31:0];
  endtask

  task automatic check(input [31:0] off, input [31:0] expected);
    logic [31:0] got;
    axi_read32(DMEM_BASE + off, got);
    if (got !== expected) begin
      errors++;
      $error("dmem[0x%02h]: got %08h, expected %08h", off, got, expected);
    end
  endtask

  logic [31:0] flag;

  initial begin
    master = new("master", dut.tb_bd_i.axi_vip_0.inst.IF);
    master.start_master();

    repeat (20) @(posedge clk);
    resetn = 1;
    repeat (5) @(posedge clk);

    // ---- data memory inputs ----
    axi_write32(DMEM_BASE + 32'h00, 32'd25);  // A
    axi_write32(DMEM_BASE + 32'h04, 32'd7);  // B
    axi_write32(DMEM_BASE + 32'h08, 32'hFFFF_FFF0);  // C = -16
    axi_write32(DMEM_BASE + 32'h20, 32'h1234_5678);  // word for byte/half tests
    axi_write32(DMEM_BASE + 32'h94, 32'd0);  // done flag cleared

    // ---- program ----
    axi_write32(IMEM_BASE + 32'h00, 32'h00002083);  // lw  x1, 0(x0)
    axi_write32(IMEM_BASE + 32'h04, 32'h00402103);  // lw  x2, 4(x0)
    axi_write32(IMEM_BASE + 32'h08, 32'h00802183);  // lw  x3, 8(x0)
    axi_write32(IMEM_BASE + 32'h0c, 32'h00208233);  // add x4, x1, x2
    axi_write32(IMEM_BASE + 32'h10, 32'h04402023);  // sw  x4, 0x40(x0)
    axi_write32(IMEM_BASE + 32'h14, 32'h40208233);  // sub x4, x1, x2
    axi_write32(IMEM_BASE + 32'h18, 32'h04402223);  // sw  x4, 0x44(x0)
    axi_write32(IMEM_BASE + 32'h1c, 32'h0020f233);  // and x4, x1, x2
    axi_write32(IMEM_BASE + 32'h20, 32'h04402423);  // sw  x4, 0x48(x0)
    axi_write32(IMEM_BASE + 32'h24, 32'h0020e233);  // or  x4, x1, x2
    axi_write32(IMEM_BASE + 32'h28, 32'h04402623);  // sw  x4, 0x4C(x0)
    axi_write32(IMEM_BASE + 32'h2c, 32'h00f0f213);  // andi x4, x1, 0xF
    axi_write32(IMEM_BASE + 32'h30, 32'h04402823);  // sw  x4, 0x50(x0)
    axi_write32(IMEM_BASE + 32'h34, 32'h0400e213);  // ori x4, x1, 0x40
    axi_write32(IMEM_BASE + 32'h38, 32'h04402a23);  // sw  x4, 0x54(x0)
    axi_write32(IMEM_BASE + 32'h3c, 32'hffb08213);  // addi x4, x1, -5
    axi_write32(IMEM_BASE + 32'h40, 32'h04402c23);  // sw  x4, 0x58(x0)
    axi_write32(IMEM_BASE + 32'h44, 32'h0ab00693);  // addi x13, x0, 0xAB
    axi_write32(IMEM_BASE + 32'h48, 32'h02d000a3);  // sb  x13, 0x21(x0)
    axi_write32(IMEM_BASE + 32'h4c, 32'h70f00713);  // addi x14, x0, 0x70F
    axi_write32(IMEM_BASE + 32'h50, 32'h02e01123);  // sh  x14, 0x22(x0)
    axi_write32(IMEM_BASE + 32'h54, 32'h02100783);  // lb  x15, 0x21(x0)
    axi_write32(IMEM_BASE + 32'h58, 32'h06f02423);  // sw  x15, 0x68(x0)
    axi_write32(IMEM_BASE + 32'h5c, 32'h02104783);  // lbu x15, 0x21(x0)
    axi_write32(IMEM_BASE + 32'h60, 32'h06f02623);  // sw  x15, 0x6C(x0)
    axi_write32(IMEM_BASE + 32'h64, 32'h02201783);  // lh  x15, 0x22(x0)
    axi_write32(IMEM_BASE + 32'h68, 32'h06f02823);  // sw  x15, 0x70(x0)
    axi_write32(IMEM_BASE + 32'h6c, 32'h02205783);  // lhu x15, 0x22(x0)
    axi_write32(IMEM_BASE + 32'h70, 32'h06f02a23);  // sw  x15, 0x74(x0)
    axi_write32(IMEM_BASE + 32'h74, 32'h02001783);  // lh  x15, 0x20(x0)
    axi_write32(IMEM_BASE + 32'h78, 32'h06f02c23);  // sw  x15, 0x78(x0)
    axi_write32(IMEM_BASE + 32'h7c, 32'h02002483);  // lw  x9, 0x20(x0)
    axi_write32(IMEM_BASE + 32'h80, 32'h06902e23);  // sw  x9, 0x7C(x0)
    axi_write32(IMEM_BASE + 32'h84, 32'h00100913);  // addi x18, x0, 1
    axi_write32(IMEM_BASE + 32'h88, 32'h09202a23);  // sw  x18, 0x94(x0)  (done flag)
    axi_write32(IMEM_BASE + 32'h8c, 32'h0000006f);  // jal x0, 0  (spin here)

    repeat (5) @(posedge clk);
    core_rst = 0;  // start the core

    flag = 0;
    for (int i = 0; i < 2000 && flag == 0; i++) begin
      repeat (10) @(posedge clk);
      axi_read32(DMEM_BASE + 32'h94, flag);
    end
    if (flag == 0) begin
      errors++;
      $error("TIMEOUT: core never wrote the done flag");
    end

    $display("--- checking results");

    check(32'h40, 32'h00000020);  // add
    check(32'h44, 32'h00000012);  // sub
    check(32'h48, 32'h00000001);  // and
    check(32'h4c, 32'h0000001f);  // or
    check(32'h50, 32'h00000009);  // andi  25 & 0xF
    check(32'h54, 32'h00000059);  // ori   25 | 0x40
    check(32'h58, 32'h00000014);  // addi  25 - 5
    check(32'h68, 32'hffffffab);  // lb  (sign-extended)
    check(32'h6c, 32'h000000ab);  // lbu
    check(32'h70, 32'h0000070f);  // lh
    check(32'h74, 32'h0000070f);  // lhu
    check(32'h78, 32'hffffab78);  // lh at offset 0, sign-extended
    check(32'h7c, 32'h070fab78);  // lw of the word modified by sb and sh
    check(32'h20, 32'h070fab78);  // same word, read back by the PS
    check(32'h94, 32'h00000001);  // done flag

    if (errors == 0) $display("PASS: core produced every expected result");
    else $display("FAIL: %0d mismatch(es)", errors);
    $finish;
  end
endmodule
