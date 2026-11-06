transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+tb_bd  -L xil_defaultlib -L xilinx_vip -L xpm -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_23 -L axi_bram_ctrl_v4_1_14 -L blk_mem_gen_v8_4_13 -L proc_sys_reset_v5_0_17 -L smartconnect_v1_0 -L axi_register_slice_v2_1_37 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.tb_bd xil_defaultlib.glbl

do {tb_bd.udo}

run 1000ns

endsim

quit -force
