//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2026.1 (lin64) Build 6511674 Tue Jun 16 11:01:26 MDT 2026
//Date        : Wed Nov  4 12:18:16 2026
//Host        : vivado running 64-bit unknown
//Command     : generate_target tb_bd.bd
//Design      : tb_bd
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "tb_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=tb_bd,x_ipVersion=1.00.a,x_ipLanguage=VERILOG}" *) (* HW_HANDOFF = "tb_bd.hwdef" *) 
module tb_bd
   (rst_0,
    s_axi_aclk_0,
    s_axi_aresetn_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST_0, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input rst_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.S_AXI_ACLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.S_AXI_ACLK_0, ASSOCIATED_RESET s_axi_aresetn_0:rst_0, CLK_DOMAIN tb_bd_s_axi_aclk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input s_axi_aclk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.S_AXI_ARESETN_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.S_AXI_ARESETN_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input s_axi_aresetn_0;

  wire [31:0]axi_vip_0_M_AXI_ARADDR;
  wire [1:0]axi_vip_0_M_AXI_ARBURST;
  wire [3:0]axi_vip_0_M_AXI_ARCACHE;
  wire [7:0]axi_vip_0_M_AXI_ARLEN;
  wire [0:0]axi_vip_0_M_AXI_ARLOCK;
  wire [2:0]axi_vip_0_M_AXI_ARPROT;
  wire axi_vip_0_M_AXI_ARREADY;
  wire [2:0]axi_vip_0_M_AXI_ARSIZE;
  wire axi_vip_0_M_AXI_ARVALID;
  wire [31:0]axi_vip_0_M_AXI_AWADDR;
  wire [1:0]axi_vip_0_M_AXI_AWBURST;
  wire [3:0]axi_vip_0_M_AXI_AWCACHE;
  wire [7:0]axi_vip_0_M_AXI_AWLEN;
  wire [0:0]axi_vip_0_M_AXI_AWLOCK;
  wire [2:0]axi_vip_0_M_AXI_AWPROT;
  wire axi_vip_0_M_AXI_AWREADY;
  wire [2:0]axi_vip_0_M_AXI_AWSIZE;
  wire axi_vip_0_M_AXI_AWVALID;
  wire axi_vip_0_M_AXI_BREADY;
  wire [1:0]axi_vip_0_M_AXI_BRESP;
  wire axi_vip_0_M_AXI_BVALID;
  wire [31:0]axi_vip_0_M_AXI_RDATA;
  wire axi_vip_0_M_AXI_RLAST;
  wire axi_vip_0_M_AXI_RREADY;
  wire [1:0]axi_vip_0_M_AXI_RRESP;
  wire axi_vip_0_M_AXI_RVALID;
  wire [31:0]axi_vip_0_M_AXI_WDATA;
  wire axi_vip_0_M_AXI_WLAST;
  wire axi_vip_0_M_AXI_WREADY;
  wire [3:0]axi_vip_0_M_AXI_WSTRB;
  wire axi_vip_0_M_AXI_WVALID;
  wire [14:0]imem_ctrl_BRAM_PORTA_ADDR;
  wire imem_ctrl_BRAM_PORTA_CLK;
  wire [31:0]imem_ctrl_BRAM_PORTA_DIN;
  wire [31:0]imem_ctrl_BRAM_PORTA_DOUT;
  wire imem_ctrl_BRAM_PORTA_EN;
  wire imem_ctrl_BRAM_PORTA_RST;
  wire [3:0]imem_ctrl_BRAM_PORTA_WE;
  wire rst_0;
  wire s_axi_aclk_0;
  wire s_axi_aresetn_0;
  wire [31:0]topmodule_0_IMEM_ADDR;
  wire topmodule_0_IMEM_CLK;
  wire [31:0]topmodule_0_IMEM_DIN;
  wire [31:0]topmodule_0_IMEM_DOUT;
  wire topmodule_0_IMEM_EN;
  wire topmodule_0_IMEM_RST;
  wire [3:0]topmodule_0_IMEM_WE;

  tb_bd_axi_vip_0_0 axi_vip_0
       (.aclk(s_axi_aclk_0),
        .aresetn(s_axi_aresetn_0),
        .m_axi_araddr(axi_vip_0_M_AXI_ARADDR),
        .m_axi_arburst(axi_vip_0_M_AXI_ARBURST),
        .m_axi_arcache(axi_vip_0_M_AXI_ARCACHE),
        .m_axi_arlen(axi_vip_0_M_AXI_ARLEN),
        .m_axi_arlock(axi_vip_0_M_AXI_ARLOCK),
        .m_axi_arprot(axi_vip_0_M_AXI_ARPROT),
        .m_axi_arready(axi_vip_0_M_AXI_ARREADY),
        .m_axi_arsize(axi_vip_0_M_AXI_ARSIZE),
        .m_axi_arvalid(axi_vip_0_M_AXI_ARVALID),
        .m_axi_awaddr(axi_vip_0_M_AXI_AWADDR),
        .m_axi_awburst(axi_vip_0_M_AXI_AWBURST),
        .m_axi_awcache(axi_vip_0_M_AXI_AWCACHE),
        .m_axi_awlen(axi_vip_0_M_AXI_AWLEN),
        .m_axi_awlock(axi_vip_0_M_AXI_AWLOCK),
        .m_axi_awprot(axi_vip_0_M_AXI_AWPROT),
        .m_axi_awready(axi_vip_0_M_AXI_AWREADY),
        .m_axi_awsize(axi_vip_0_M_AXI_AWSIZE),
        .m_axi_awvalid(axi_vip_0_M_AXI_AWVALID),
        .m_axi_bready(axi_vip_0_M_AXI_BREADY),
        .m_axi_bresp(axi_vip_0_M_AXI_BRESP),
        .m_axi_bvalid(axi_vip_0_M_AXI_BVALID),
        .m_axi_rdata(axi_vip_0_M_AXI_RDATA),
        .m_axi_rlast(axi_vip_0_M_AXI_RLAST),
        .m_axi_rready(axi_vip_0_M_AXI_RREADY),
        .m_axi_rresp(axi_vip_0_M_AXI_RRESP),
        .m_axi_rvalid(axi_vip_0_M_AXI_RVALID),
        .m_axi_wdata(axi_vip_0_M_AXI_WDATA),
        .m_axi_wlast(axi_vip_0_M_AXI_WLAST),
        .m_axi_wready(axi_vip_0_M_AXI_WREADY),
        .m_axi_wstrb(axi_vip_0_M_AXI_WSTRB),
        .m_axi_wvalid(axi_vip_0_M_AXI_WVALID));
  tb_bd_blk_mem_gen_0_0 imem_bram
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,imem_ctrl_BRAM_PORTA_ADDR}),
        .addrb(topmodule_0_IMEM_ADDR),
        .clka(imem_ctrl_BRAM_PORTA_CLK),
        .clkb(topmodule_0_IMEM_CLK),
        .dina(imem_ctrl_BRAM_PORTA_DIN),
        .dinb(topmodule_0_IMEM_DIN),
        .douta(imem_ctrl_BRAM_PORTA_DOUT),
        .doutb(topmodule_0_IMEM_DOUT),
        .ena(imem_ctrl_BRAM_PORTA_EN),
        .enb(topmodule_0_IMEM_EN),
        .rsta(imem_ctrl_BRAM_PORTA_RST),
        .rstb(topmodule_0_IMEM_RST),
        .wea(imem_ctrl_BRAM_PORTA_WE),
        .web(topmodule_0_IMEM_WE));
  tb_bd_axi_bram_ctrl_0_0 imem_ctrl
       (.bram_addr_a(imem_ctrl_BRAM_PORTA_ADDR),
        .bram_clk_a(imem_ctrl_BRAM_PORTA_CLK),
        .bram_en_a(imem_ctrl_BRAM_PORTA_EN),
        .bram_rddata_a(imem_ctrl_BRAM_PORTA_DOUT),
        .bram_rst_a(imem_ctrl_BRAM_PORTA_RST),
        .bram_we_a(imem_ctrl_BRAM_PORTA_WE),
        .bram_wrdata_a(imem_ctrl_BRAM_PORTA_DIN),
        .s_axi_aclk(s_axi_aclk_0),
        .s_axi_araddr(axi_vip_0_M_AXI_ARADDR[14:0]),
        .s_axi_arburst(axi_vip_0_M_AXI_ARBURST),
        .s_axi_arcache(axi_vip_0_M_AXI_ARCACHE),
        .s_axi_aresetn(s_axi_aresetn_0),
        .s_axi_arlen(axi_vip_0_M_AXI_ARLEN),
        .s_axi_arlock(axi_vip_0_M_AXI_ARLOCK),
        .s_axi_arprot(axi_vip_0_M_AXI_ARPROT),
        .s_axi_arready(axi_vip_0_M_AXI_ARREADY),
        .s_axi_arsize(axi_vip_0_M_AXI_ARSIZE),
        .s_axi_arvalid(axi_vip_0_M_AXI_ARVALID),
        .s_axi_awaddr(axi_vip_0_M_AXI_AWADDR[14:0]),
        .s_axi_awburst(axi_vip_0_M_AXI_AWBURST),
        .s_axi_awcache(axi_vip_0_M_AXI_AWCACHE),
        .s_axi_awlen(axi_vip_0_M_AXI_AWLEN),
        .s_axi_awlock(axi_vip_0_M_AXI_AWLOCK),
        .s_axi_awprot(axi_vip_0_M_AXI_AWPROT),
        .s_axi_awready(axi_vip_0_M_AXI_AWREADY),
        .s_axi_awsize(axi_vip_0_M_AXI_AWSIZE),
        .s_axi_awvalid(axi_vip_0_M_AXI_AWVALID),
        .s_axi_bready(axi_vip_0_M_AXI_BREADY),
        .s_axi_bresp(axi_vip_0_M_AXI_BRESP),
        .s_axi_bvalid(axi_vip_0_M_AXI_BVALID),
        .s_axi_rdata(axi_vip_0_M_AXI_RDATA),
        .s_axi_rlast(axi_vip_0_M_AXI_RLAST),
        .s_axi_rready(axi_vip_0_M_AXI_RREADY),
        .s_axi_rresp(axi_vip_0_M_AXI_RRESP),
        .s_axi_rvalid(axi_vip_0_M_AXI_RVALID),
        .s_axi_wdata(axi_vip_0_M_AXI_WDATA),
        .s_axi_wlast(axi_vip_0_M_AXI_WLAST),
        .s_axi_wready(axi_vip_0_M_AXI_WREADY),
        .s_axi_wstrb(axi_vip_0_M_AXI_WSTRB),
        .s_axi_wvalid(axi_vip_0_M_AXI_WVALID));
  tb_bd_topmodule_0_0 topmodule_0
       (.clk(s_axi_aclk_0),
        .imem_addr(topmodule_0_IMEM_ADDR),
        .imem_clk(topmodule_0_IMEM_CLK),
        .imem_din(topmodule_0_IMEM_DIN),
        .imem_dout(topmodule_0_IMEM_DOUT),
        .imem_en(topmodule_0_IMEM_EN),
        .imem_rst(topmodule_0_IMEM_RST),
        .imem_we(topmodule_0_IMEM_WE),
        .rst(rst_0));
endmodule
