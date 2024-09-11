// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

/*
    Deploy and interact with counter in a local Anvil node using forge script and cast:

    forge script script/Counter.s.sol:CounterScript --rpc-url=http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
    cast st 0x68b1d87f95878fe05b998f19b66f4baba5de1aed 0
    cast send 0x68b1d87f95878fe05b998f19b66f4baba5de1aed "increment()" --private-key=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 
*/


contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new Counter();
        vm.stopBroadcast();
    }
}
