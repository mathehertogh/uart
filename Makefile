BITSTREAM ?= build/top.bit
SOURCES ?= $(wildcard hdl/*.v hdl/*.sv hdl/*.vhd xdc/*.xcd)
VIVADO ?= vivado -mode batch -nolog -nojournal -source

.PHONY: deploy
deploy: $(BITSTREAM)
	$(VIVADO) deploy.tcl

.PHONY: bitstream
bitstream: $(BITSTREAM)

$(BITSTREAM): $(SOURCES)
	mkdir -p build
	$(VIVADO) build.tcl

.PHONY: clean
clean:
	rm -rf .cache .Xil build
