create_clock -period 12.000 -name clk [get_ports clk]
set_input_delay -clock clk 1.500 [get_ports {Ta Tb}]
set_output_delay -clock clk 1.500 [get_ports {La Lb}]