`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2025 16:15:31
// Design Name: 
// Module Name: traffic_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_controller(
       input clk,
       input reset,
       input Ta,
       input Tb,
       output reg [1:0] La,
       output reg [1:0] Lb);
                     
reg [1:0] state, nextstate;

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

always @ (posedge clk, posedge reset)
begin
if(reset)state<= S0;
else state<= nextstate;
end

always @ (*) 
begin
case(state)
S0:nextstate = (Ta==0)? S1:S0;
S1:nextstate = S2;
S2:nextstate = (Tb==0)? S3:S2;
S3:nextstate = S0;
default: nextstate = S0;
endcase
end

always @(*) begin
 case(state)
  S0: begin
      La= 2'b00;
      Lb= 2'b10;
  end
  S1: begin
      La= 2'b01;
      Lb= 2'b10;
  end
  S2: begin
      La= 2'b10;
      Lb= 2'b00;
  end
  S3: begin
      La= 2'b10;
      Lb= 2'b01;
  end
 endcase
end    


endmodule
