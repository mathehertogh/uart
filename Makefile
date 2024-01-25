BITSTREAM ?= build/top.bit
SOURCES ?= $(wildcard hdl/*.v hdl/*.sv hdl/*.vhd xdc/*.xcd)
VIVADO ?= vivado -mode batch -nolog -nojournal -source

.PHONY: deploy
deploy: $(BITSTREAM)
	$(VIVADO) deploy.tcl

.PHONY: bitstream
bitstream: $(BITSTREAM)

.PHONY: test
test:
	sudo cat /dev/ttyUSB1

.PHONY: clean
clean:
	rm -rf .cache .Xil build

$(BITSTREAM): $(SOURCES)
	mkdir -p build
	$(VIVADO) build.tcl
