.PHONY: pkg build

pkg:
	packr2

build: pkg
	go build -o build/bin/openrpc-cli-gen

dev: build
	./build/bin/openrpc-cli-gen ./testdata/eth_openrpc.json ethrpc
	# TODO: Add build for resulting generated CLI program.

clean:
	rm -rf ./build/*