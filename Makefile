.PHONY: pkg build deps dev dev_unstable examples

# pkg bundles the static resources we need for building the binaries.
pkg:
	packr2

# build runs the necessary static building command 'pkg', and then builds the Go project.
build: pkg
	go build -o build/bin/openrpc-cli-generator
	@echo "Done. Run: build/bin/openrpc-cli-generator"

# dev and dev_unstable encapsulate some typical development processes using examples.
# _unstable means the steps (and/or targets, or openrpc document resources) may not work.
# These commands will remove (aka 'clean') the generation build targets directories, but
# won't remove the static testdata (which are static openrpc documents).
dev: clean build examples_stable
dev_unstable: clean build examples_unstable

# examples_stable only runs passing examples.
examples_stable: pkg example_simplemath example_petstore

# examples_unstable runs examples that might be broken.
examples_unstable: pkg example_ethereum_stable example_ethereum_unstable


example_ethereum_master: clean build
	@echo "Building from github.com/etclabscore/ethereum-json-specification master document"
	# [ -f  ./testdata/ethereum_master.json ] || wget -O ./testdata/ethereum_master.json --no-check-certificate https://raw.githubusercontent.com/etclabscore/ethereum-json-rpc-specification/master/openrpc.json
	[ -f  ./testdata/ethereum_master.json ] || wget -O ./testdata/ethereum_master.json --no-check-certificate https://github.com/etclabscore/ethereum-json-rpc-specification/raw/1.0.10/openrpc.json
	go run . ./testdata/ethereum_master.json ethrpc_master
	go build -o ./build/bin/ethrpc.example_ethereum_master ./build/target/go/ethrpc_master
	./build/bin/ethrpc.example_ethereum_master --help

example_ethereum_stable: clean build
	@echo "Building example 1"
	[ -f  ./testdata/ethereum-open-rpc-json-spec-1.0.0_1.0.10.json ] || wget -O ./testdata/ethereum-open-rpc-json-spec-1.0.0_1.0.10.json --no-check-certificate https://raw.githubusercontent.com/etclabscore/ethereum-json-rpc-specification/f4c0c08bea2cee4639affaec77f437efe8596d07/openrpc.json
	go run . ./testdata/ethereum-open-rpc-json-spec-1.0.0_1.0.10.json ethrpc
	go build -o ./build/bin/ethrpc.example_ethereum_stable ./build/target/go/ethrpc
	./build/bin/ethrpc.example_ethereum_stable --help

example_ethereum_unstable: clean build
	@echo "Building example 2"
	[ -f ./testdata/ethereum-open-rpc-json-spec-1.2.4_1.0.10.json ] || wget -O ./testdata/ethereum-open-rpc-json-spec-1.2.4_1.0.10.json --no-check-certificate https://gist.githubusercontent.com/meowsbits/4da4c08765679dac1899543002d1f545/raw/f09816722484b2fa87d3e3f5a2ee8e3611143d0c/ethereum-json-rpc.json
	go run . ./testdata/ethereum-open-rpc-json-spec-1.2.4_1.0.10.json ethrpc
	go build -o ./build/bin/ethrpc.example_ethereum_unstable ./build/target/go/ethrpc
	./build/bin/ethrpc.example_ethereum_unstable --help

example_simplemath: clean build
	@echo "Building simplemath example"
	[ -f ./testdata/simplemath-1.0.0-rc1_1.0.0.json ] || wget -O ./testdata/simplemath-1.0.0-rc1_1.0.0.json --no-check-certificate https://github.com/open-rpc/examples/raw/c7f641b2f1f4225aaf2e13137d152744d98c1273/service-descriptions/simple-math-openrpc.json
	go run . ./testdata/simplemath-1.0.0-rc1_1.0.0.json simplemath
	go build -o ./build/bin/simplemath ./build/target/go/simplemath
	./build/bin/simplemath --help

example_petstore: clean build
	@echo "Building petstore example"
	[ -f ./testdata/petstore-1.0.0-rc1_1.0.0.json ] || wget -O ./testdata/petstore-1.0.0-rc1_1.0.0.json --no-check-certificate https://github.com/open-rpc/examples/raw/c7f641b2f1f4225aaf2e13137d152744d98c1273/service-descriptions/petstore-openrpc.json
	go run . ./testdata/petstore-1.0.0-rc1_1.0.0.json petstore
	go build -o ./build/bin/petstore ./build/target/go/petstore
	./build/bin/petstore --help

clean: clean_bin clean_targets
clean_bin:
	rm -rf ./build/bin/*
clean_targets:
	rm -rf ./build/target/*