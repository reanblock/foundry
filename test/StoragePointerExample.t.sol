// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {StoragePointerUnOptimized, StoragePointerOptimized} from "../src/StoragePointerExample.sol";

contract StoragePointerTest is Test {
    StoragePointerUnOptimized public spUnoptimized;
    StoragePointerOptimized public spOptimized;

    function setUp() public {
        spUnoptimized = new StoragePointerUnOptimized();
        spOptimized = new StoragePointerOptimized();
    }

    // run this test with the gas report option
    // forge test -vvv --gas-report --mc StoragePointerTest
    function test_callGetMaxValue() view public {
        spUnoptimized.returnLastSeenSecondsAgo(0);
        spOptimized.returnLastSeenSecondsAgoOptimized((0));
    }
}
