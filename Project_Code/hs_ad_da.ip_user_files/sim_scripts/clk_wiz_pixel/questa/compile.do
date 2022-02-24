vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -sv "+incdir+../../../ipstatic" \
"F:/English-software/VIVADO2019/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"F:/English-software/VIVADO2019/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"F:/English-software/VIVADO2019/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" \
"../../../../hs_ad_da.srcs/sources_1/ip/clk_wiz_pixel/clk_wiz_pixel_clk_wiz.v" \
"../../../../hs_ad_da.srcs/sources_1/ip/clk_wiz_pixel/clk_wiz_pixel.v" \

vlog -work xil_defaultlib \
"glbl.v"

