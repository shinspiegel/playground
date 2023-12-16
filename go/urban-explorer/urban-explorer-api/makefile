BINARY_NAME=urban_explorer
MAIN_SOURCE_FILE=main.go
BUILD_FILE=./bin/$(BINARY_NAME) # Final path for the binary



.PHONY: all dev test clean build run


all: test build


dev:
	source ./.env; go run main.go --env ./.env --dev


build: 
	go build -o $(BUILD_FILE) $(MAIN_SOURCE_FILE)


test: 
	go test ./...


clean: 
	go clean
	rm -f $(BUILD_FILE)


deps:
	go get  ./...

