transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/xil_defaultlib
vlib riviera/axi_vip_v1_1_23
vlib riviera/axi_bram_ctrl_v4_1_14
vlib riviera/blk_mem_gen_v8_4_13

vmap xilinx_vip riviera/xilinx_vip
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap xil_defaultlib riviera/xil_defaultlib
vmap axi_vip_v1_1_23 riviera/axi_vip_v1_1_23
vmap axi_bram_ctrl_v4_1_14 riviera/axi_bram_ctrl_v4_1_14
vmap blk_mem_gen_v8_4_13 riviera/blk_mem_gen_v8_4_13

vlog -work xilinx_vip  -incr "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l xil_defaultlib -l axi_vip_v1_1_23 -l axi_bram_ctrl_v4_1_14 -l blk_mem_gen_v8_4_13 \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l xil_defaultlib -l axi_vip_v1_1_23 -l axi_bram_ctrl_v4_1_14 -l blk_mem_gen_v8_4_13 \
"../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l xil_defaultlib -l axi_vip_v1_1_23 -l axi_bram_ctrl_v4_1_14 -l blk_mem_gen_v8_4_13 \
"../../../bd/tb_bd/ip/tb_bd_axi_vip_0_0/sim/tb_bd_axi_vip_0_0_pkg.sv" \

vlog -work axi_vip_v1_1_23  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l xil_defaultlib -l axi_vip_v1_1_23 -l axi_bram_ctrl_v4_1_14 -l blk_mem_gen_v8_4_13 \
"../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/4d28/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l xil_defaultlib -l axi_vip_v1_1_23 -l axi_bram_ctrl_v4_1_14 -l blk_mem_gen_v8_4_13 \
"../../../bd/tb_bd/ip/tb_bd_axi_vip_0_0/sim/tb_bd_axi_vip_0_0.sv" \

vcom -work axi_bram_ctrl_v4_1_14 -93  -incr \
"../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/02d4/hdl/axi_bram_ctrl_v4_1_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/tb_bd/ip/tb_bd_axi_bram_ctrl_0_0/sim/tb_bd_axi_bram_ctrl_0_0.vhd" \

vlog -work blk_mem_gen_v8_4_13  -incr -v2k5 "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l xil_defaultlib -l axi_vip_v1_1_23 -l axi_bram_ctrl_v4_1_14 -l blk_mem_gen_v8_4_13 \
"../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/59f9/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l xil_defaultlib -l axi_vip_v1_1_23 -l axi_bram_ctrl_v4_1_14 -l blk_mem_gen_v8_4_13 \
"../../../bd/tb_bd/ip/tb_bd_blk_mem_gen_0_0/sim/tb_bd_blk_mem_gen_0_0.v" \
"../../../bd/tb_bd/sim/tb_bd.v" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/tb_bd/ipshared/ec67/hdl" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l axi_infrastructure_v1_1_0 -l xil_defaultlib -l axi_vip_v1_1_23 -l axi_bram_ctrl_v4_1_14 -l blk_mem_gen_v8_4_13 \
"../../../bd/tb_bd/ip/tb_bd_topmodule_0_0/sim/tb_bd_topmodule_0_0.sv" \

vlog -work xil_defaultlib \
"glbl.v"

