# openrpc-cli-generator

A tool that can be used to generate a command line interface (CLI) from a given [Open-RPC](https://github.com/open-rpc) document.

## Usage

### Install

#### Go

:construction: Not sure this works yet. 

```sh
go get -u github.com/etclabscore/openrpc-cli-generator/...
openrpc-cli-generator --help
```

#### From source
```sh
$ git clone https://github.com/etclabscore/openrpc-cli-generator.git
$ cd openrpc-cli-generator
$ make build
$ ./build/bin/openrpc-cli-generator --help
```

### Interface

```sh
$ openrpc-cli-generator [path/to/openrpc.json] <programName>
```

### Examples

```sh
$ openrpc-cli-generator ./testdata/eth_openrpc.json ethrpc
$ go run ./build/target/go/ethrpc /ethrpc.example1 --help
This is an auto-generated CLI interface for an Open-RPC compliant API.

Open-RPC Version: 1.0.10

Run 'ethrpc completion --help' to learn about auto-auto-completion! It's easy!

Usage:
  ethrpc [command]

Available Commands:
  completion                                 Generates bash completion scripts
  eth_blockNumber                            Returns the number of most recent block.
  eth_call                                   Executes a new message call (locally) immediately without creating a transaction on the block chain.
  eth_chainId                                Returns the currently configured chain id
  eth_coinbase                               Returns the client coinbase address.
  eth_estimateGas                            Generates and returns an estimate of how much gas is necessary to allow the transaction to complete. The transaction will not be added to the blockchain. Note that the estimate may be significantly more than the amount of gas actually used by the transaction, for a variety of reasons including EVM mechanics and node performance.
  eth_gasPrice                               Returns the current price per gas in wei
  eth_getBalance                             Returns Ether balance of a given or account or contract
  eth_getBlockByHash                         Gets a block for a given hash
  eth_getBlockByNumber                       Gets a block for a given number salad
  eth_getBlockTransactionCountByHash         Returns the number of transactions in a block from a block matching the given block hash.
  eth_getBlockTransactionCountByNumber       Returns the number of transactions in a block from a block matching the given block number.
  eth_getCode                                Returns code at a given contract address
  eth_getFilterChanges                       Polling method for a filter, which returns an array of logs which occurred since last poll.
  eth_getFilterLogs                          Returns an array of all logs matching filter with given id.
  eth_getLogs                                Returns an array of all logs matching a given filter object.
  eth_getProof                               Returns the account- and storage-values of the specified account including the Merkle-proof.
  eth_getRawTransactionByBlockHashAndIndex   Returns raw transaction data of a transaction with the given hash.
  eth_getRawTransactionByBlockNumberAndIndex Returns raw transaction data of a transaction with the given hash.
  eth_getRawTransactionByHash                Returns raw transaction data of a transaction with the given hash.
  eth_getStorageAt                           Gets a storage value from a contract address, a position, and an optional blockNumber
  eth_getTransactionByBlockHashAndIndex      Returns the information about a transaction requested by the block hash and index of which it was mined.
  eth_getTransactionByBlockNumberAndIndex    Returns the information about a transaction requested by the block hash and index of which it was mined.
  eth_getTransactionByHash                   Returns the information about a transaction requested by transaction hash.
  eth_getTransactionCount                    Returns the number of transactions sent from an address
  eth_getTransactionReceipt                  Returns the receipt information of a transaction by its hash.
  eth_getUncleByBlockHashAndIndex            Returns information about a uncle of a block by hash and uncle index position.
  eth_getUncleByBlockNumberAndIndex          Returns information about a uncle of a block by hash and uncle index position.
  eth_getUncleCountByBlockHash               Returns the number of uncles in a block from a block matching the given block hash.
  eth_getUncleCountByBlockNumber             Returns the number of uncles in a block from a block matching the given block number.
  eth_getWork                                Returns the hash of the current block, the seedHash, and the boundary condition to be met ('target').
  eth_hashrate                               Returns the number of hashes per second that the node is mining with.
  eth_mining                                 Returns true if client is actively mining new blocks.
  eth_newBlockFilter                         Creates a filter in the node, to notify when a new block arrives. To check if the state has changed, call eth_getFilterChanges.
  eth_newFilter                              Creates a filter object, based on filter options, to notify when the state changes (logs). To check if the state has changed, call eth_getFilterChanges.
  eth_newPendingTransactionFilter            Creates a filter in the node, to notify when new pending transactions arrive. To check if the state has changed, call eth_getFilterChanges.
  eth_pendingTransactions                    Returns the pending transactions list
  eth_protocolVersion                        Returns the current ethereum protocol version.
  eth_sendRawTransaction                     Creates new message call transaction or a contract creation for signed transactions.
  eth_submitHashrate                         Returns an array of all logs matching a given filter object.
  eth_submitWork                             Used for submitting a proof-of-work solution.
  eth_syncing                                Returns an object with data about the sync status or false.
  eth_uninstallFilter                        Uninstalls a filter with given id. Should always be called when watch is no longer needed. Additionally Filters timeout when they aren't requested with eth_getFilterChanges for a period of time.
  help                                       Help about any command
  net_listening                              returns listening status
  net_peerCount                              number of peers
  net_version                                chain ID associated with network
  web3_clientVersion                         current client version
  web3_sha3                                  Hashes data

Flags:
      --config string      config file (default is $HOME/.ethrpc.yaml)
  -h, --help               help for ethrpc
      --http-addr string   Address for JSON-RPC HTTP calls (default "http://localhost:8545")
  -t, --toggle             Help message for toggle


```

### 

## Develop

```sh
$ make dev
```

