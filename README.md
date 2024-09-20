# Foundry

## Setup Foundry in exisitng project

Clone the existing project repo then run the following innside the project root directory

NOTE: using `--force` may overwrite somefiles (like your README.md and gitigore files) - so back these up first. This command will also install forge-std and commit the changes to your local repo.

```
forge init --force
```

Then install specific dependencies that match the project requirements. For example:

```
forge install OpenZeppelin/openzeppelin-contracts@v3.2.0
```

**Next steps:**

- If you need to install multiple versions of a library you can add then to specific folders and shown [here](#forge-install).
- Update your [foundry.toml](./foundry.toml) file with the required `rpc_endpoints` and `remappings` entries for your project.
- You may also need to update the `src` in  [foundry.toml](./foundry.toml)  to `src = "contracts"` if the projects contracts are in this folder (such as with Hardhat or Truffle).
- Delete the `Counter.*.sol` example contract files.
  ```
  rm src/Counter.sol
  rm test/Counter.t.sol
  rm script/Counter.s.sol
  ```
- Compile all the project contracts using `forge build` and check the artifacts are saved in the `out` directory.
- Commit all your changes to your Github repo.
- Restart Visual Studio Code as this is required to have the solidity dependencies clickable in the source code (perhaps its a bug so I find a restart is required)
- Add a test file for one of the more basic contracts to make sure everything is wired up correctly. Below is an example for a contract `contracts/Market.sol`:
  ```solidity
    // SPDX-License-Identifier: UNLICENSED
    pragma solidity ^0.6.0;
    pragma experimental ABIEncoderV2;

    import {Test, console} from "forge-std/Test.sol";
    import {Market} from "../contracts/Market.sol";

    contract MarketTest is Test {
        Market market;

        function setUp() public {
            market = new Market();
        }

        function test_deployed() public {
            console.log(address(market));
        }
    }
  ```
- Finally you can add the following section to your `.gitignore` file:
  ```
  # Foundry
  cache/
  out/
  !/broadcast
  /broadcast/**/dry-run/
  ```

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

### Forge Script

To run a script such as Counter.s.sol on a blockchain network you should first add your private key to the keystore like so:

```
cast wallet import auditor --interactive
```

Now run the script like so:

```
forge script script/Counter.s.sol:CounterScript /
                --rpc-url sepolia /
                --account auditor / 
                --sender 0x471cd8eaa5d60c2ed4dd42cc3b0de75ecfbbda62 / 
                --broadcast -vvvv
                
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
