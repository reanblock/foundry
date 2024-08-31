// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract Misc_Test is Test {
    uint decimals = 10**18;
    function test_something() public {
        console.log(somthing(9));
    }
    
    function somthing(uint a) internal returns(uint b) {
        b = (a / 10) * decimals;
    }
}