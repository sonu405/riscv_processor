transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+system_bd  -L xil_defaultlib -L xilinx_vip -L xpm -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_23 -L processing_system7_vip_v1_0_25 -L blk_mem_gen_v8_4_13 -L axi_bram_ctrl_v4_1_14 -L axi_lite_ipif_v3_1_0 -L interrupt_control_v3_2_0 -L axi_gpio_v2_0_38 -L proc_sys_reset_v5_0_17 -L smartconnect_v1_0 -L axi_register_slice_v2_1_37 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.system_bd xil_defaultlib.glbl

do {system_bd.udo}

run 1000ns

endsim

quit -force
