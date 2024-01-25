# Setup an in-memory project to tell Vivado our configuration.
create_project -part xcvu9p-flga2104-2L-e -in_memory -force mathes_project
set_property -dict [list \
	BOARD_PART xilinx.com:vcu118:part0:2.4 \
	TARGET_LANGUAGE {Verilog} \
	DEFAULT_LIB {xil_defaultlib} \
	IP_REPO_PATHS ip \
] [current_project]

# Build IP components.
read_ip ip/clk_wiz_0/clk_wiz_0.xci
generate_target all [get_ips]

# Read (our own) source files.
read_verilog -sv "hdl/uart.sv"
read_verilog -sv "hdl/top.sv"
read_xdc "xdc/top.xdc"

# Synthesize design.
synth_design -top top -part xcvu9p-flga2104-2L-e
report_timing_summary
write_checkpoint -force  build/post_synth.dcp

# Place & Route.
opt_design
write_checkpoint -force build/post_opt.dcp
place_design
write_checkpoint -force  build/post_place.dcp
route_design
report_timing_summary
write_checkpoint -force  build/post_route.dcp

# Generate bitstream.
write_bitstream -force build/top.bit
