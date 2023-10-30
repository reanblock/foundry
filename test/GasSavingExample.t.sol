// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {GasSavingExample} from "../src/GasSavingExample.sol";

contract GasSavingExampleTest is Test {
    GasSavingExample public gse;

    function setUp() public {
        gse = new GasSavingExample();
    }

    function test_packingAndUnpacking(uint80 x, uint80 y) public {
        gse.packVariables(x, y);
        (uint80 xret, uint80 yret) = gse.unpackVariables();
        assertEq(x, xret);
        assertEq(y, yret);
    }
}