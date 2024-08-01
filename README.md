## Foundry

### Cast

Parse address from returned slot data:

```
cast parse-bytes32-address $(cast st 0x400E0B7106FFC2Dbc1e4c4EC096C288Ae6663cc8 208 -r base_mainnet)
```

### Forge Inspect

Use forge cli to inspect methods, abi, storage etc for any contract:

```
forge inspect ERC20BondingCurveFactoryV1 methods 
```

### Forge Install

Use the following to install a specific version of openzeppelin contracts along side the latest. This ensures the are stored into different folders under the `lib` directory and and then be referenced accordingly in the project ([ref](https://ethereum.stackexchange.com/questions/153530/how-can-i-install-multiple-versions-of-a-dependency-in-foundry)).

```
# notice show openzeppelin-contracts-solc-0.7= is prepended to the dependency
# this will name the dependency "openzeppelin-contracts-solc-0.7" instead of the default name "openzeppelin-contracts"
forge install openzeppelin-contracts-solc-0.7=openzeppelin/openzeppelin-contracts@v3.4.2-solc-0.7

# now install the latest version of openzeppelin-contracts as follows
forge install openzeppelin/openzeppelin-contracts
```

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
