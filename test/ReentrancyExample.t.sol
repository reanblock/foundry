// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ReentrancyExample} from '../src/ReentrancyExample.sol';
import {ReentrancyAttack} from './ReentrancyAttack.sol';

contract ReentrancyExampleTest is Test {
    error ReentrancyGuardReentrantCall();

    ReentrancyExample public reentrancyExample;
    function setUp() public {
        reentrancyExample = new ReentrancyExample();
    }

    function test_deployer() public {
        assert(address(reentrancyExample) != address(0x0));
    }

    function test_canBeReenteredFunction () public {
        ReentrancyAttack reentrancyAttack = new ReentrancyAttack(address(reentrancyExample));
        reentrancyAttack.attack();
        // attaker calls once and reenteres once so entered count will be 2
        assertEq(reentrancyExample.enteredCount(), 2);
    }

    function test_canNotBeReenteredFunction() public {
        reentrancyExample.canNotBeReentered();
        // attaker calls once and reenteres but the rentrancy guard reverts the
        // second call so entered count will be just 1
        assertEq(reentrancyExample.enteredCount(), 1);
    }
    fallback() external {
        // NOTE: vm.expectRevert does not work in the fallback
        // but the ReentrancyGuardReentrantCall revert is happening!
        // vm.expectRevert(ReentrancyGuardReentrantCall.selector);
        reentrancyExample.canNotBeReentered();
    }
}
