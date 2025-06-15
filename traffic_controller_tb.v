`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2025 16:34:25
// Design Name: 
// Module Name: traffic_controller_tb
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


module traffic_controller_tb();
  reg clk, reset, Ta, Tb;
  wire [1:0] La, Lb;

  traffic_controller dut (
    .clk(clk),
    .reset(reset),
    .Ta(Ta),
    .Tb(Tb),
    .La(La),
    .Lb(Lb)
  );

  always #2.5 clk = ~clk;
  always #7.5 Ta = ~Ta;
  always #10 Tb = ~Tb;

  initial begin
    $dumpfile("traffic_waveform.vcd");
    $dumpvars(0, traffic_controller_tb);
    clk = 0;
    reset = 1;
    Ta = 0;
    Tb = 0;

    $display("Starting simulation...");
    #5 reset = 0;
    #30;
    if (La != 2'b10)
      $display("WARNING at time %t: La not GREEN when expected", $time);
    else
      $display("PASS at time %t: La is GREEN", $time);

    #70 $finish;
  end
  always @(posedge clk) begin
    if (!reset) begin
      $display("Time: %t | Ta: %b | Tb: %b | La: %b | Lb: %b | State: %b", 
                $time, Ta, Tb, La, Lb, dut.state);
    end
  end

endmodule
