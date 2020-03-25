.PHONY: pkg build

pkg:
	packr2

build: pkg
	go build -o build/bin/openrpc-cli-gen

dev: build
	./build/bin/openrpc-cli-gen ./testdata/ethereum-json-rpc.json ethrpc
	cd build/go/ethrpc
#	go build -o ethrpc .


clean:
	rm -rf ./build/*