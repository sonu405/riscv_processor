// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
// DO NOT MODIFY THIS FILE.

// MODULE VLNV: xilinx.com:ip:axi_bram_ctrl:4.1

`timescale 1ps / 1ps

`include "vivado_interfaces.svh"

module axi_bram_ctrl_0_sv (
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI" *)
  (* X_INTERFACE_MODE = "slave S_AXI" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 15, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
  vivado_aximm_v1_0.slave S_AXI,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire s_axi_aclk,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire s_axi_aresetn,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire bram_rst_a,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire bram_clk_a,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire bram_en_a,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [3:0] bram_we_a,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [14:0] bram_addr_a,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [31:0] bram_wrdata_a,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire [31:0] bram_rddata_a,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire bram_rst_b,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire bram_clk_b,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire bram_en_b,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [3:0] bram_we_b,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [14:0] bram_addr_b,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [31:0] bram_wrdata_b,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire [31:0] bram_rddata_b
);

  // interface wire assignments
  assign S_AXI.BID = 0;
  assign S_AXI.BUSER = 0;
  assign S_AXI.RID = 0;
  assign S_AXI.RUSER = 0;

  axi_bram_ctrl_0 inst (
    .s_axi_aclk(s_axi_aclk),
    .s_axi_aresetn(s_axi_aresetn),
    .s_axi_awaddr(S_AXI.AWADDR),
    .s_axi_awlen(S_AXI.AWLEN),
    .s_axi_awsize(S_AXI.AWSIZE),
    .s_axi_awburst(S_AXI.AWBURST),
    .s_axi_awlock(S_AXI.AWLOCK),
    .s_axi_awcache(S_AXI.AWCACHE),
    .s_axi_awprot(S_AXI.AWPROT),
    .s_axi_awvalid(S_AXI.AWVALID),
    .s_axi_awready(S_AXI.AWREADY),
    .s_axi_wdata(S_AXI.WDATA),
    .s_axi_wstrb(S_AXI.WSTRB),
    .s_axi_wlast(S_AXI.WLAST),
    .s_axi_wvalid(S_AXI.WVALID),
    .s_axi_wready(S_AXI.WREADY),
    .s_axi_bresp(S_AXI.BRESP),
    .s_axi_bvalid(S_AXI.BVALID),
    .s_axi_bready(S_AXI.BREADY),
    .s_axi_araddr(S_AXI.ARADDR),
    .s_axi_arlen(S_AXI.ARLEN),
    .s_axi_arsize(S_AXI.ARSIZE),
    .s_axi_arburst(S_AXI.ARBURST),
    .s_axi_arlock(S_AXI.ARLOCK),
    .s_axi_arcache(S_AXI.ARCACHE),
    .s_axi_arprot(S_AXI.ARPROT),
    .s_axi_arvalid(S_AXI.ARVALID),
    .s_axi_arready(S_AXI.ARREADY),
    .s_axi_rdata(S_AXI.RDATA),
    .s_axi_rresp(S_AXI.RRESP),
    .s_axi_rlast(S_AXI.RLAST),
    .s_axi_rvalid(S_AXI.RVALID),
    .s_axi_rready(S_AXI.RREADY),
    .bram_rst_a(bram_rst_a),
    .bram_clk_a(bram_clk_a),
    .bram_en_a(bram_en_a),
    .bram_we_a(bram_we_a),
    .bram_addr_a(bram_addr_a),
    .bram_wrdata_a(bram_wrdata_a),
    .bram_rddata_a(bram_rddata_a),
    .bram_rst_b(bram_rst_b),
    .bram_clk_b(bram_clk_b),
    .bram_en_b(bram_en_b),
    .bram_we_b(bram_we_b),
    .bram_addr_b(bram_addr_b),
    .bram_wrdata_b(bram_wrdata_b),
    .bram_rddata_b(bram_rddata_b)
  );

endmodule
