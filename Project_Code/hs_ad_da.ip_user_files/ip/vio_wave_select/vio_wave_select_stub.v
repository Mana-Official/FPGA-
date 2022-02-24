// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Sat Feb 19 16:18:33 2022
// Host        : PC-20200514NKPU running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Desktoop/Studio_FPGA/DD1_AD_DA_HDMI/20_hs_ad_da/hs_ad_da.srcs/sources_1/ip/vio_wave_select/vio_wave_select_stub.v
// Design      : vio_wave_select
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2019.2" *)
module vio_wave_select(clk, probe_out0)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_out0[1:0]" */;
  input clk;
  output [1:0]probe_out0;
endmodule
