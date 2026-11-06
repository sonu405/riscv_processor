//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2026.1 (lin64) Build 6511674 Tue Jun 16 11:01:26 MDT 2026
//Date        : Thu Nov  5 18:51:57 2026
//Host        : vivado running 64-bit unknown
//Command     : generate_target tb_bd_wrapper.bd
//Design      : tb_bd_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module tb_bd_wrapper
   (rst_0,
    s_axi_aclk_0,
    s_axi_aresetn_0);
  input rst_0;
  input s_axi_aclk_0;
  input s_axi_aresetn_0;

  wire rst_0;
  wire s_axi_aclk_0;
  wire s_axi_aresetn_0;

  tb_bd tb_bd_i
       (.rst_0(rst_0),
        .s_axi_aclk_0(s_axi_aclk_0),
        .s_axi_aresetn_0(s_axi_aresetn_0));
endmodule
