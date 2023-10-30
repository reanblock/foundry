// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Constants, NoConstants} from "../src/ConstantsExample.sol";

contract ConstantsTest is Test {
    Constants public constants;
    NoConstants public noConstants;

    function setUp() public {
        constants = new Constants();
        noConstants = new NoConstants();
    }

    // run this test with the gas report option
    // forge test -vvv --gas-report --mc ConstantsTest
    function test_callGetMaxValue() view public {
        constants.get_max_value();
        noConstants.get_max_value();
    }
}
