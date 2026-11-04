vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/axi_vip_v1_1_23

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap axi_vip_v1_1_23 modelsim_lib/msim/axi_vip_v1_1_23

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

vlog -work axi_infrastructure_v1_1_0 -64 -incr -mfcu  "+incdir+../../../ipstatic/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"../../../ipstatic/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_23 -L xilinx_vip "+incdir+../../../ipstatic/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"../../../../rvcore.gen/sources_1/ip/axi_vip_0/sim/axi_vip_0_pkg.sv" \

vlog -work axi_vip_v1_1_23 -64 -incr -mfcu  -sv -L axi_vip_v1_1_23 -L xilinx_vip "+incdir+../../../ipstatic/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"../../../ipstatic/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_23 -L xilinx_vip "+incdir+../../../ipstatic/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" \
"../../../../rvcore.gen/sources_1/ip/axi_vip_0/sim/axi_vip_0.sv" \

vlog -work xil_defaultlib \
"glbl.v"

