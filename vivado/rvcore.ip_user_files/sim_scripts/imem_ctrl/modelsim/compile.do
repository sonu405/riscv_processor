vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/axi_bram_ctrl_v4_1_14
vlib modelsim_lib/msim/xil_defaultlib

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap axi_bram_ctrl_v4_1_14 modelsim_lib/msim/axi_bram_ctrl_v4_1_14
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xilinx_vip -64 -incr -mfcu  -sv -L axi_vip_v1_1_23 -L xilinx_vip "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vcom -work axi_bram_ctrl_v4_1_14 -64 -93  \
"../../../ipstatic/hdl/axi_bram_ctrl_v4_1_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../../rvcore.gen/sources_1/ip/imem_ctrl/sim/imem_ctrl.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

