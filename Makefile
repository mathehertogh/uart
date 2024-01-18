BITSTREAM ?= out/led_blink.bit
SOURCES ?= $(wildcard hdl/*.v hdl/*.sv hdl/*.vhd xdc/*.xcd)
VIVADO ?= vivado -mode batch -nolog -nojournal -source

.PHONY: deploy
deploy: $(BITSTREAM)
	$(VIVADO) deploy.tcl

.PHONY: bitstream
bitstream: $(BITSTREAM)

$(BITSTREAM): $(SOURCES)
	mkdir -p out
	$(VIVADO) build.tcl
