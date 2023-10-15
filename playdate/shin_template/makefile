.PHONY: build
.PHONY: open
.PHONY: run_latest

SDK = $(shell egrep '^\s*SDKRoot' ~/.Playdate/config | head -n 1 | cut -c9-)
SDKBIN=$(SDK)/bin
GAME=$(shell grep 'name' source/pdxinfo | awk -F '=' '{print $$2}')
SIM=Playdate Simulator
TIMESTAMP=$(shell date "+%Y%m%d%H%M")
LATEST_BUILD=$(shell ls -dt build/*/ | head -n 1)

build: clean compile open

clean:
	rm -rf 'build/$(GAME).pdx'

compile: Source/main.lua
	mkdir -p "build/$(TIMESTAMP)"
	"$(SDKBIN)/pdc" 'source' 'build/$(TIMESTAMP)/$(GAME).pdx'
	"$(SDKBIN)/pdc" 'source' 'build/$(GAME).pdx'
	
open:
	open -a '$(SDKBIN)/$(SIM).app/Contents/MacOS/$(SIM)' 'build/$(TIMESTAMP)/$(GAME).pdx'

run_latest:
	open -a '$(SDKBIN)/$(SIM).app/Contents/MacOS/$(SIM)' '$(LATEST_BUILD)/$(GAME).pdx'	