transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+imem_ctrl  -L xil_defaultlib -L xilinx_vip -L axi_bram_ctrl_v4_1_14 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.imem_ctrl xil_defaultlib.glbl

do {imem_ctrl.udo}

run 1000ns

endsim

quit -force
