vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/axi_vip_v1_1_23
vlib modelsim_lib/msim/axi_bram_ctrl_v4_1_14
vlib modelsim_lib/msim/blk_mem_gen_v8_4_13

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap axi_vip_v1_1_23 modelsim_lib/msim/axi_vip_v1_1_23
vmap axi_bram_ctrl_v4_1_14 modelsim_lib/msim/axi_bram_ctrl_v4_1_14
vmap blk_mem_gen_v8_4_13 modelsim_lib/msim/blk_mem_gen_v8_4_13

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

vlog -work axi_infrastructure_v1_1_0 -64 -incr -mfcu  "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_23 -L xilinx_vip "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"../../../bd/tb_bd/ip/tb_bd_axi_vip_0_0/sim/tb_bd_axi_vip_0_0_pkg.sv" \

vlog -work axi_vip_v1_1_23 -64 -incr -mfcu  -sv -L axi_vip_v1_1_23 -L xilinx_vip "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/4d28/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_23 -L xilinx_vip "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"../../../bd/tb_bd/ip/tb_bd_axi_vip_0_0/sim/tb_bd_axi_vip_0_0.sv" \

vcom -work axi_bram_ctrl_v4_1_14 -64 -93  \
"../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/02d4/hdl/axi_bram_ctrl_v4_1_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/tb_bd/ip/tb_bd_axi_bram_ctrl_0_0/sim/tb_bd_axi_bram_ctrl_0_0.vhd" \

vlog -work blk_mem_gen_v8_4_13 -64 -incr -mfcu  "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/59f9/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"../../../bd/tb_bd/ip/tb_bd_blk_mem_gen_0_0/sim/tb_bd_blk_mem_gen_0_0.v" \
"../../../bd/tb_bd/sim/tb_bd.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_23 -L xilinx_vip "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"../../../bd/tb_bd/ip/tb_bd_topmodule_0_0/sim/tb_bd_topmodule_0_0.sv" \

vlog -work xil_defaultlib \
"glbl.v"

