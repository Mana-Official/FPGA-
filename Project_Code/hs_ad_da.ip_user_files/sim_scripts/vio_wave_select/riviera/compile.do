vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../../hs_ad_da.srcs/sources_1/ip/vio_wave_select/hdl/verilog" "+incdir+../../../../hs_ad_da.srcs/sources_1/ip/vio_wave_select/hdl" \
"F:/English-software/VIVADO2019/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"F:/English-software/VIVADO2019/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"F:/English-software/VIVADO2019/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../hs_ad_da.srcs/sources_1/ip/vio_wave_select/hdl/verilog" "+incdir+../../../../hs_ad_da.srcs/sources_1/ip/vio_wave_select/hdl" \
"../../../../hs_ad_da.srcs/sources_1/ip/vio_wave_select/sim/vio_wave_select.v" \

vlog -work xil_defaultlib \
"glbl.v"

