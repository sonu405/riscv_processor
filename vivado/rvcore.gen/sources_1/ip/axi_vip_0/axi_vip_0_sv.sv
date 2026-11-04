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

// MODULE VLNV: xilinx.com:ip:axi_vip:1.1

`timescale 1ps / 1ps

`include "vivado_interfaces.svh"

module axi_vip_0_sv (
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI" *)
  (* X_INTERFACE_MODE = "master M_AXI" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXI, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
  vivado_aximm_v1_0.master M_AXI,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire aclk,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire aresetn
);

  // interface wire assignments
  assign M_AXI.ARID = 0;
  assign M_AXI.ARUSER = 0;
  assign M_AXI.AWID = 0;
  assign M_AXI.AWUSER = 0;
  assign M_AXI.WID = 0;
  assign M_AXI.WUSER = 0;

  axi_vip_0 inst (
    .aclk(aclk),
    .aresetn(aresetn),
    .m_axi_awaddr(M_AXI.AWADDR),
    .m_axi_awlen(M_AXI.AWLEN),
    .m_axi_awsize(M_AXI.AWSIZE),
    .m_axi_awburst(M_AXI.AWBURST),
    .m_axi_awlock(M_AXI.AWLOCK),
    .m_axi_awcache(M_AXI.AWCACHE),
    .m_axi_awprot(M_AXI.AWPROT),
    .m_axi_awregion(M_AXI.AWREGION),
    .m_axi_awqos(M_AXI.AWQOS),
    .m_axi_awvalid(M_AXI.AWVALID),
    .m_axi_awready(M_AXI.AWREADY),
    .m_axi_wdata(M_AXI.WDATA),
    .m_axi_wstrb(M_AXI.WSTRB),
    .m_axi_wlast(M_AXI.WLAST),
    .m_axi_wvalid(M_AXI.WVALID),
    .m_axi_wready(M_AXI.WREADY),
    .m_axi_bresp(M_AXI.BRESP),
    .m_axi_bvalid(M_AXI.BVALID),
    .m_axi_bready(M_AXI.BREADY),
    .m_axi_araddr(M_AXI.ARADDR),
    .m_axi_arlen(M_AXI.ARLEN),
    .m_axi_arsize(M_AXI.ARSIZE),
    .m_axi_arburst(M_AXI.ARBURST),
    .m_axi_arlock(M_AXI.ARLOCK),
    .m_axi_arcache(M_AXI.ARCACHE),
    .m_axi_arprot(M_AXI.ARPROT),
    .m_axi_arregion(M_AXI.ARREGION),
    .m_axi_arqos(M_AXI.ARQOS),
    .m_axi_arvalid(M_AXI.ARVALID),
    .m_axi_arready(M_AXI.ARREADY),
    .m_axi_rdata(M_AXI.RDATA),
    .m_axi_rresp(M_AXI.RRESP),
    .m_axi_rlast(M_AXI.RLAST),
    .m_axi_rvalid(M_AXI.RVALID),
    .m_axi_rready(M_AXI.RREADY)
  );

endmodule
