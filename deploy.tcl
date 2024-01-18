set bitstream out/led_blink.bit

open_hw_manager
connect_hw_server
current_hw_target
open_hw_target
set_property PROGRAM.FILE $bitstream [current_hw_device]
program_hw_devices [current_hw_device]
refresh_hw_device [current_hw_device]
puts "Deployed bitstream $bitstream to device [current_hw_device]"
