BINARY_NAME=urban_explorer
MAIN_SOURCE_FILE=main.go
BUILD_FILE=./bin/$(BINARY_NAME) # Final path for the binary

# Go commands
GO_DEV=go run main.go --env "./.env"
GO_BUILD=go build
GO_CLEAN=go clean
GO_TEST=go test
GO_GET=go get


.PHONY: all dev test clean build run


all: test build


dev:
	$(GO_DEV)


build: 
	$(GO_BUILD) -o $(BUILD_FILE) $(MAIN_SOURCE_FILE)


test: 
	$(GO_TEST) ./...


clean: 
	$(GO_CLEAN)
	rm -f $(BUILD_FILE)


deps:
	$(GO_GET) ./...

