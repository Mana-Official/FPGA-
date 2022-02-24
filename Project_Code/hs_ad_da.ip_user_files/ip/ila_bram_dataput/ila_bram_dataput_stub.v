// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Sat Feb 19 10:51:09 2022
// Host        : PC-20200514NKPU running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Desktoop/Studio_FPGA/DD1_AD_DA_HDMI/20_hs_ad_da/hs_ad_da.srcs/sources_1/ip/ila_bram_dataput/ila_bram_dataput_stub.v
// Design      : ila_bram_dataput
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2019.2" *)
module ila_bram_dataput(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6, probe7)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[0:0],probe1[0:0],probe2[0:0],probe3[7:0],probe4[10:0],probe5[11:0],probe6[11:0],probe7[10:0]" */;
  input clk;
  input [0:0]probe0;
  input [0:0]probe1;
  input [0:0]probe2;
  input [7:0]probe3;
  input [10:0]probe4;
  input [11:0]probe5;
  input [11:0]probe6;
  input [10:0]probe7;
endmodule
