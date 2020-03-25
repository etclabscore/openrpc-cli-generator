.PHONY: pkg build dev examples example1 example2

pkg:
	packr2

build: pkg
	go build -o build/bin/openrpc-cli-gen

dev: pkg clean_targets examples

examples: pkg example1 example2 example3

example1: clean_targets
	@echo "Building example 1"
	go run . ./testdata/eth_openrpc.json ethrpc
	go build -o ./build/bin/ethrpc.example1 ./build/target/go/ethrpc
	./build/bin/ethrpc.example1 --help | head -15

example2: clean_targets
	@echo "Building example 2"
	go run . ./testdata/ethereum-json-rpc.json ethrpc
	go build -o ./build/bin/ethrpc.example2 ./build/target/go/ethrpc
	./build/bin/ethrpc.example2 --help | head -15

example3: clean_targets
	@echo "Building example 3"
	go run . ./testdata/ethereum-json-rpc2.json ethrpc
	go build -o ./build/bin/ethrpc.example3 ./build/target/go/ethrpc
	./build/bin/ethrpc.example3 --help | head -15

clean: clean_bin clean_targets

clean_bin:
	rm -rf ./build/bin/*

clean_targets:
	rm -rf ./build/target/*