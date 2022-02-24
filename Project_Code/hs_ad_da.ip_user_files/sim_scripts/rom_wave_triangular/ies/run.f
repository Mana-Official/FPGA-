-makelib ies_lib/xpm -sv \
  "F:/English-software/VIVADO2019/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "F:/English-software/VIVADO2019/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "F:/English-software/VIVADO2019/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_4 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../hs_ad_da.srcs/sources_1/ip/rom_wave_triangular/sim/rom_wave_triangular.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

