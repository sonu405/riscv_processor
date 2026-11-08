transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_23
vlib riviera/processing_system7_vip_v1_0_25
vlib riviera/xil_defaultlib
vlib riviera/blk_mem_gen_v8_4_13
vlib riviera/axi_bram_ctrl_v4_1_14
vlib riviera/axi_lite_ipif_v3_1_0
vlib riviera/interrupt_control_v3_2_0
vlib riviera/axi_gpio_v2_0_38
vlib riviera/proc_sys_reset_v5_0_17
vlib riviera/smartconnect_v1_0
vlib riviera/axi_register_slice_v2_1_37

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_23 riviera/axi_vip_v1_1_23
vmap processing_system7_vip_v1_0_25 riviera/processing_system7_vip_v1_0_25
vmap xil_defaultlib riviera/xil_defaultlib
vmap blk_mem_gen_v8_4_13 riviera/blk_mem_gen_v8_4_13
vmap axi_bram_ctrl_v4_1_14 riviera/axi_bram_ctrl_v4_1_14
vmap axi_lite_ipif_v3_1_0 riviera/axi_lite_ipif_v3_1_0
vmap interrupt_control_v3_2_0 riviera/interrupt_control_v3_2_0
vmap axi_gpio_v2_0_38 riviera/axi_gpio_v2_0_38
vmap proc_sys_reset_v5_0_17 riviera/proc_sys_reset_v5_0_17
vmap smartconnect_v1_0 riviera/smartconnect_v1_0
vmap axi_register_slice_v2_1_37 riviera/axi_register_slice_v2_1_37

vlog -work xilinx_vip  -incr "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/vivado/2026.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"/home/vivado/2026.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/vivado/2026.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/home/vivado/2026.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"/home/vivado/2026.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_23  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/4d28/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_25  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_processing_system7_0_0/sim/system_bd_processing_system7_0_0.v" \

vlog -work blk_mem_gen_v8_4_13  -incr -v2k5 "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/59f9/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_dmem_bram_0/sim/system_bd_dmem_bram_0.v" \

vcom -work axi_bram_ctrl_v4_1_14 -93  -incr \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/02d4/hdl/axi_bram_ctrl_v4_1_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/system_bd/ip/system_bd_dmem_ctrl_0/sim/system_bd_dmem_ctrl_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_imem_bram_0/sim/system_bd_imem_bram_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/system_bd/ip/system_bd_imem_ctrl_0/sim/system_bd_imem_ctrl_0.vhd" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_topmodule_0_0/sim/system_bd_topmodule_0_0.sv" \

vcom -work axi_lite_ipif_v3_1_0 -93  -incr \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/de33/hdl/axi_lite_ipif_v3_1_rfs.vhd" \

vcom -work interrupt_control_v3_2_0 -93  -incr \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/e2ca/hdl/interrupt_control_v3_2_rfs.vhd" \

vcom -work axi_gpio_v2_0_38 -93  -incr \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/6ccd/hdl/axi_gpio_v2_0_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/system_bd/ip/system_bd_axi_gpio_0_0/sim/system_bd_axi_gpio_0_0.vhd" \

vcom -work proc_sys_reset_v5_0_17 -93  -incr \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/9438/hdl/proc_sys_reset_v5_0_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_1/sim/bd_3c1f_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/0848/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_2/sim/bd_3c1f_arsw_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_3/sim/bd_3c1f_rsw_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_4/sim/bd_3c1f_awsw_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_5/sim/bd_3c1f_wsw_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_6/sim/bd_3c1f_bsw_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/3d9a/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_7/sim/bd_3c1f_s00mmu_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/7785/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_8/sim/bd_3c1f_s00tr_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/3051/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_9/sim/bd_3c1f_s00sic_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/852f/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_10/sim/bd_3c1f_s00a2s_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_11/sim/bd_3c1f_sarn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_12/sim/bd_3c1f_srn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_13/sim/bd_3c1f_sawn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_14/sim/bd_3c1f_swn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_15/sim/bd_3c1f_sbn_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/fca9/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_16/sim/bd_3c1f_m00s2a_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_17/sim/bd_3c1f_m00arn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_18/sim/bd_3c1f_m00rn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_19/sim/bd_3c1f_m00awn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_20/sim/bd_3c1f_m00wn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_21/sim/bd_3c1f_m00bn_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/c7d2/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_22/sim/bd_3c1f_m00e_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_23/sim/bd_3c1f_m01s2a_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_24/sim/bd_3c1f_m01arn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_25/sim/bd_3c1f_m01rn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_26/sim/bd_3c1f_m01awn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_27/sim/bd_3c1f_m01wn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_28/sim/bd_3c1f_m01bn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_29/sim/bd_3c1f_m01e_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_30/sim/bd_3c1f_m02s2a_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_31/sim/bd_3c1f_m02arn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_32/sim/bd_3c1f_m02rn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_33/sim/bd_3c1f_m02awn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_34/sim/bd_3c1f_m02wn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_35/sim/bd_3c1f_m02bn_0.sv" \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/ip/ip_36/sim/bd_3c1f_m02e_0.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/bd_0/sim/bd_3c1f.v" \

vcom -work smartconnect_v1_0 -93  -incr \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/21d5/hdl/sc_ultralite_v1_0_rfs.vhd" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/21d5/hdl/sc_ultralite_v1_0_rfs.sv" \

vlog -work axi_register_slice_v2_1_37  -incr -v2k5 "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/8c55/hdl/axi_register_slice_v2_1_rfs.v" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/ip/system_bd_axi_smc_0/sim/system_bd_axi_smc_0.sv" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/system_bd/ip/system_bd_rst_ps7_0_100M_0/sim/system_bd_rst_ps7_0_100M_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/ec67/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/df05/hdl" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rvcore.gen/sources_1/bd/system_bd/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../2026.1/data/rsb/busdef" "+incdir+/home/vivado/2026.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_23 -l processing_system7_vip_v1_0_25 -l xil_defaultlib -l blk_mem_gen_v8_4_13 -l axi_bram_ctrl_v4_1_14 -l axi_lite_ipif_v3_1_0 -l interrupt_control_v3_2_0 -l axi_gpio_v2_0_38 -l proc_sys_reset_v5_0_17 -l smartconnect_v1_0 -l axi_register_slice_v2_1_37 \
"../../../bd/system_bd/sim/system_bd.v" \

vlog -work xil_defaultlib \
"glbl.v"

