`timescale 1ns / 1ps


module dry_grid(
    input   clk_pixel,
    input   de,
    input   xvs,

    output reg valid_grid
    );

parameter   loc_1 = 192*1- 1;
parameter   loc_2 = 192*2- 1;
parameter   loc_3 = 192*3- 1;
parameter   loc_4 = 192*4- 1;
parameter   loc_5 = 192*5- 1;
parameter   loc_6 = 192*6- 1;
parameter   loc_7 = 192*7- 1;
parameter   loc_8 = 192*8- 1;
parameter   loc_9 = 192*9- 1;
parameter   loc_10 = 192*10- 1;

parameter   mid = 1080/2;

always @(posedge clk_pixel)begin
    if(cnt_xhs ==  mid)begin
        valid_grid <= 1;    
    end
    else begin
        case(cnt_pixel)
            loc_1,loc_2,loc_3,loc_4,loc_5,loc_6,loc_7,loc_8,loc_9,loc_10:
            begin
                valid_grid <= 1;
            end

            default:    
                valid_grid <= 0;    

        endcase
    end

end


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
ila_grid ila_grid (
	.clk(clk_pixel), // input wire clk


	.probe0(de), // input wire [0:0]  probe0  
	.probe1(xvs), // input wire [0:0]  probe1 
	.probe2(valid_grid), // input wire [0:0]  probe2 
	.probe3(cnt_pixel), // input wire [11:0]  probe3 
	.probe4(cnt_xhs) // input wire [11:0]  probe4
);

endmodule
