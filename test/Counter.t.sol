// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function test_SendingEthToContract() public {
        assertEq(address(counter).balance, 0);

        address payable counterPayable = payable(address(counter));
        (bool success, ) = counterPayable.call{value: 1 ether}("");

        assertTrue(success);
        assertEq(address(counter).balance, 1 ether);
    }

    function test_AddressCodeCheck() public {
        // check deployed contract code length
        assertGt(address(counter).code.length, 0);

        // eoa address code length should be zero
        address alice = makeAddr("alice");
        assertEq(alice.code.length, 0);
    }
}
