
module hs_ad_da(
    input                 sys_clk     ,  //系统时钟
    input                 sys_rst_n   ,  //系统复位，低电平有效

    /*hdmi interface*/
    output  HDMI_CLK_P,  
    output  HDMI_CLK_N,    
    output [2:0] HDMI_TX_P,
    output [2:0] HDMI_TX_N ,

    //DA芯片接口
    output                da_clk      ,  //DA(AD9708)驱动时钟,最大支持125Mhz时钟
    output    [7:0]       da_data     ,  //输出给DA的数据
    //AD芯片接口
    input     [7:0]       ad_data     ,  //AD输入数据
    //模拟输入电压超出量程标志(本次试验未用到)
    input                 ad_otr      ,  //0:在量程范围 1:超出量程
    output                ad_clk         //AD(AD9280)驱动时钟,最大支持32Mhz时钟 
);

//wire define 
wire      [7:0]    rd_addr;             //ROM读地址
reg      [7:0]    rd_data;             //ROM读出的数据

reg      [7:0]    rd_addr_sine;        //正弦波    
wire      [7:0]    rd_data_sine;
reg      [7:0]    rd_addr_triangular;  //三角波    
wire      [7:0]    rd_data_triangular;
reg      [7:0]    rd_addr_sawtooth;    //锯齿波    
wire      [7:0]    rd_data_sawtooth;

//*****************************************************
//**                    main code
//*****************************************************

//DA数据发送
da_wave_send u_da_wave_send(
    .clk         (sys_clk), 
    .rst_n       (sys_rst_n),
    .rd_data     (rd_data),
    .rd_addr     (rd_addr),
    .da_clk      (da_clk),  
    .da_data     (da_data)
    );

//ROM存储波形
/*正弦波*/
rom_256x8b  rom_wave_sine (
  .clka  (sys_clk),    // input wire clka
  .addra (rd_addr_sine),    // input wire [7 : 0] addra
  .douta (rd_data_sine)     // output wire [7 : 0] douta
);
/*三角波*/
 rom_wave_triangular  rom_wave_triangular (
  .clka  (sys_clk),    // input wire clka
  .addra (rd_addr_triangular),    // input wire [7 : 0] addra
  .douta (rd_data_triangular)     // output wire [7 : 0] douta
);
/*锯齿波*/
 rom_wave_sawtooth  rom_wave_sawtooth (
  .clka  (sys_clk),    // input wire clka
  .addra (rd_addr_sawtooth),    // input wire [7 : 0] addra
  .douta (rd_data_sawtooth)     // output wire [7 : 0] douta
);

//输出波形选择器-VIO
parameter   wave_sine       = 2'd0;
parameter   wave_triangular = 2'd1;
parameter   wave_sawtooth   = 2'd2;
wire [1:0]  vio_wave;

vio_wave_select vio_wave_select (
  .clk(sys_clk),                // input wire clk
  .probe_out0(vio_wave)  // output wire [1 : 0] probe_out0
);

always @(posedge sys_clk) begin
    case (vio_wave)
        wave_sine:begin
            rd_addr_sine <= rd_addr;
            rd_data <= rd_data_sine;
        end

        wave_triangular:begin
            rd_addr_triangular <= rd_addr;
            rd_data <= rd_data_triangular;
        end

        wave_sawtooth:begin
            rd_addr_sawtooth <= rd_addr;
            rd_data <= rd_data_sawtooth;
        end

        default: ;
    endcase    
end



//AD数据接收
ad_wave_rec u_ad_wave_rec(
    .clk         (sys_clk),
    .rst_n       (sys_rst_n),
    .ad_data     (ad_data),
    .ad_otr      (ad_otr),
    .ad_clk      (ad_clk)
    );    

//ILA采集AD数据
ila_0  ila_0 (
    .clk         (ad_clk ), // input wire clk
    .probe0      (ad_otr ), // input wire [0:0]  probe0  
    .probe1      (ad_data)  // input wire [7:0]  probe0  
);

//HDMI显示
wire    [23 : 0] vid_pData;
rgb2dvi_0 HDMI_show (
  .TMDS_Clk_p(HDMI_CLK_P),    // output wire TMDS_Clk_p
  .TMDS_Clk_n(HDMI_CLK_N),    // output wire TMDS_Clk_n
  .TMDS_Data_p(HDMI_TX_P),  // output wire [2 : 0] TMDS_Data_p
  .TMDS_Data_n(HDMI_TX_N),  // output wire [2 : 0] TMDS_Data_n
  .aRst_n(locked),            // input wire aRst_n
  .vid_pData(vid_pData),      // input wire [23 : 0] vid_pData
  .vid_pVDE(vid_pVDE),        // input wire vid_pVDE
  .vid_pHSync(vid_pHSync),    // input wire vid_pHSync
  .vid_pVSync(vid_pVSync),    // input wire vid_pVSync
  .PixelClk(clk_pixel),        // input wire PixelClk
  .SerialClk(clk_pixel_x5)      // input wire SerialClk
);

assign  vid_pData = (valid_grid | valid_waveform)?24'hffffff:24'd0;//绘制栅格

//时钟IP
wire    locked;
wire    clk_pixel,clk_pixel_x5;
  clk_wiz_pixel clk_wiz_pixel
   (
    // Clock out ports
    .clk_out1(clk_pixel),     // output clk_out1
    .clk_out2(clk_pixel_x5),     // output clk_out2
    // Status and control signals
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(sys_clk));      // input clk_in1

//HDMI输出时序
wire    vid_pVDE,vid_pHSync,vid_pVSync;
video_driver#(
    .multiple(1)
) video_driver(
    .pixel_clk      (clk_pixel),
    .sys_rst_n      (locked),

    .video_hs       (vid_pHSync),
    .video_vs       (vid_pVSync),
    .video_de       (vid_pVDE),
    .video_rgb      ( ),//output

    .pixel_xpos     ( ),
    .pixel_ypos     ( ),
    .pixel_data     (24'h0)
    );

//绘制栅格
wire    valid_grid;
dry_grid dry_grid(
    .clk_pixel(clk_pixel),
    .de(vid_pVDE),
    .xvs(vid_pVSync),

    .valid_grid(valid_grid)
    );

//绘制波形
wire    valid_waveform;
dry_waveform dry_waveform(
    .clk_pixel(clk_pixel),
    .de(vid_pVDE),
    .xvs(vid_pVSync),

    .clk_ad(ad_clk),
    .data_ad(ad_data),
    .valid_waveform(valid_waveform)
    );
endmodule