`timescale 1ns / 1ps


module dry_waveform(
    input   clk_pixel,
    input   de,
    input   xvs,

    input       clk_ad,
    input [7:0] data_ad,

    output reg  valid_waveform
    );

always @(posedge clk_pixel) begin
    if(!de)
      addrb <= 8'd0;  
    else if(de)begin
      addrb <= addrb + 1'b1;
    end
end

always @(posedge clk_pixel) begin
    if(addrb == cnt_pixel)begin
        if(cnt_xhs == (doutb + 412))//计算偏差量，叠加到显示波形中去，计算的�?�应在VS上升沿完�? 540-128=412�?
            valid_waveform <= 1'b1;
        else    
            valid_waveform <= 1'b0;
    end
    else   
        valid_waveform <= 1'b0;
end


always @(posedge clk_ad) begin
    if(wea == 1)begin
        addra <= addra + 1'b1;
    end
end

//控制刷新频率，便于观�?
reg [7:0] cnt_refresh = 0;
always @(posedge clk_pixel) begin
    if(cnt_refresh >= 128)
        cnt_refresh <= 8'd0;    
    else if(rise_Vs)
        cnt_refresh <= cnt_refresh + 1'b1;
end


assign  wea = (!xvs) & (cnt_refresh == 120);//在消隐区间刷新波形数�?

wire         wea; 
reg  [10:0]  addra,addrb;
wire [7:0]   doutb;
blk_mem_gen_0 blk_mem_gen_0 (
  .clka(clk_ad),    // input wire clka
  .ena(1),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [7 : 0] addra
  .dina(data_ad),    // input wire [7 : 0] dina
  .clkb(clk_pixel),    // input wire clkb
  .enb(1),      // input wire enb
  .addrb(addrb),  // input wire [7 : 0] addrb
  .doutb(doutb)  // output wire [7 : 0] doutb
);


//-------------------------------------------------------------------counter hs/vs
wire cnt_vs = xvs;
reg Vs_d0;
wire cnt_de = de;
reg De_d0;
wire rise_Vs = {Vs_d0,cnt_vs} == 2'b01;
wire fall_Vs = {Vs_d0,cnt_vs} == 2'b10;
wire rise_De = {De_d0,cnt_de} == 2'b01;
wire fall_De = {De_d0,cnt_de} == 2'b10;
always @(posedge clk_pixel) begin
  Vs_d0 <= cnt_vs;
  De_d0 <= cnt_de;
end

reg   [11:0]  cnt_pixel,cnt_xhs;
reg   [31:0]  R0_data_o_1;
always @(posedge clk_pixel) begin
  if(rise_Vs)begin
    cnt_xhs   <= 12'd0;  
  end
  else if(fall_Vs)
    cnt_xhs <= 12'd0; 
  else if(fall_De)
    cnt_xhs <= cnt_xhs + 12'd1;
  else
    cnt_xhs <= cnt_xhs;     

  if(rise_Vs)
    cnt_pixel <= 12'd0;    
  else if(fall_De)
    cnt_pixel <= 12'd0; 
  else if(cnt_de)
    cnt_pixel <= cnt_pixel + 12'd1;
  else
    cnt_pixel <= cnt_pixel;     
end

//-------------------------------------------------------------------end
ila_ram_datain ila_ram_datain (
	.clk(clk_ad), // input wire clk


	.probe0(wea), // input wire [0:0]  probe0  
	.probe1(data_ad), // input wire [7:0]  probe1 
	.probe2(addra) // input wire [10:0]  probe2
);

ila_bram_dataput ila_bram_dataout (
	.clk(clk_pixel), // input wire clk


	.probe0(valid_waveform), // input wire [0:0]  probe0  
	.probe1(de), // input wire [0:0]  probe1 
	.probe2(xvs), // input wire [0:0]  probe2 
	.probe3(doutb), // input wire [7:0]  probe3 
	.probe4(addrb), // input wire [10:0]  probe4
	.probe5(cnt_pixel), // input wire [11:0]  probe3 
	.probe6(cnt_xhs),  // input wire [11:0]  probe4
    .probe7(cnt_refresh)
);


endmodule
