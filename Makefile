.PHONY: pkg build deps dev examples example1 example2

# Mostly to show provenance of testdata.
deps: fetch_testdata
fetch_testdata:
	wget -O ./testdata/ethereum-openrpc-json-spec-1.0.0-1.0.10.json --no-check-certificate https://raw.githubusercontent.com/etclabscore/ethereum-json-rpc-specification/f4c0c08bea2cee4639affaec77f437efe8596d07/openrpc.json
	wget -O ./testdata/ethereum-openrpc-json-spec-1.2.4-1.0.10.json --no-check-certificate https://gist.githubusercontent.com/meowsbits/4da4c08765679dac1899543002d1f545/raw/f09816722484b2fa87d3e3f5a2ee8e3611143d0c/ethereum-json-rpc.json

build: pkg
	go build -o build/bin/openrpc-cli-generator
	@echo "Done. Run: build/bin/openrpc-cli-generator"
pkg:
	packr2

dev: clean build examples
dev2: clean build example2

examples: pkg example1 example2
example1: clean build
	@echo "Building example 1"
	go run . ./testdata/ethereum-openrpc-json-spec-1.0.0-1.0.10.json ethrpc
	go build -o ./build/bin/ethrpc.example1 ./build/target/go/ethrpc
	./build/bin/ethrpc.example1 --help
example2: clean build
	@echo "Building example 2"
	go run . ./testdata/ethereum-openrpc-json-spec-1.2.4-1.0.10.json ethrpc
	go build -o ./build/bin/ethrpc.example2 ./build/target/go/ethrpc
	./build/bin/ethrpc.example2 --help

clean: clean_bin clean_targets
clean_bin:
	rm -rf ./build/bin/*
clean_targets:
	rm -rf ./build/target/*