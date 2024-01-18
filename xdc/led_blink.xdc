# GPIO Push Buttons (*_c means center)
set_property PACKAGE_PIN BD23 [get_ports button_c]
set_property IOSTANDARD LVCMOS18 [get_ports button_c]

# GPIO LEDs
set_property PACKAGE_PIN AT32 [get_ports led[0]]
set_property PACKAGE_PIN AV34 [get_ports led[1]]
set_property PACKAGE_PIN AY30 [get_ports led[2]]
set_property PACKAGE_PIN BB32 [get_ports led[3]]
set_property PACKAGE_PIN BF32 [get_ports led[4]]
set_property PACKAGE_PIN AU37 [get_ports led[5]]
set_property PACKAGE_PIN AV36 [get_ports led[6]]
set_property PACKAGE_PIN BA37 [get_ports led[7]]
set_property IOSTANDARD LVCMOS12 [get_ports led[0]]
set_property IOSTANDARD LVCMOS12 [get_ports led[1]]
set_property IOSTANDARD LVCMOS12 [get_ports led[2]]
set_property IOSTANDARD LVCMOS12 [get_ports led[3]]
set_property IOSTANDARD LVCMOS12 [get_ports led[4]]
set_property IOSTANDARD LVCMOS12 [get_ports led[5]]
set_property IOSTANDARD LVCMOS12 [get_ports led[6]]
set_property IOSTANDARD LVCMOS12 [get_ports led[7]]

# System clock 300 MHz
set_property PACKAGE_PIN G31 [get_ports sysclk_300mhz_p]
set_property PACKAGE_PIN F31 [get_ports sysclk_300mhz_n]
set_property IOSTANDARD LVDS [get_ports sysclk_300mhz_p]
set_property IOSTANDARD LVDS [get_ports sysclk_300mhz_n]

# set_property -dict { PACKAGE_PIN AL20    IOSTANDARD LVCMOS18 } [get_ports clk]
# create_clock -add -name fpga_emcclk -period 11.11 -waveform {0 5} [get_ports clk]

# set_property -dict {PACKAGE_PIN AY23 IOSTANDARD LVDS} [get_ports clk]
# set_property -dict {PACKAGE_PIN AY24 IOSTANDARD LVDS} [get_ports clk]

# UART
set_property PACKAGE_PIN AW25 [get_ports uart_rx]
set_property PACKAGE_PIN BB21 [get_ports uart_tx]
set_property PACKAGE_PIN AY25 [get_ports uart_cts]
# set_property PACKAGE_PIN BB22 [get_ports uart_rts]
set_property IOSTANDARD LVCMOS18 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS18 [get_ports uart_tx]
set_property IOSTANDARD LVCMOS18 [get_ports uart_cts]
# set_property IOSTANDARD LVCMOS18 [get_ports uart_rts]
