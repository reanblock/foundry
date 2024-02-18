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

    function test_IfOrConditional() view public {
        // If either condition in the if statement is FALSE, the modifier reverts the transaction,
        // if (
        //     msg.sender == address(kernel) ||
        //     !kernel.modulePermissions(KEYCODE(), Policy(msg.sender), msg.sig)
        // ) revert Module_PolicyNotPermitted(msg.sender);
        
        
        if (
            // msg.sender == address(kernel) ||
            false ||
            // !kernel.modulePermissions(KEYCODE(), Policy(msg.sender), msg.sig)
            true
        ) console2.log("TRUE");

        console2.log("HERE ANYWAY");
        
        // {
        //     console2.log("TRUE");
        // } else {
        //     console2.log("FALSE");
        // }
    }
}
