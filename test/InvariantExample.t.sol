// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {InvariantExample} from "../src/InvariantExample.sol";

contract InvariantExample1Test is Test {

    InvariantExample foo;

    function setUp() external {
        foo = new InvariantExample();
    }

    function invariant_A() external {
        assertEq(foo.val1() + foo.val2(), foo.val3());
    }

    function invariant_B() external {
        assertGe(foo.val1() + foo.val2(), foo.val1());
    }
}
