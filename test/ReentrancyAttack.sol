// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ReentrancyExample} from '../src/ReentrancyExample.sol';

contract ReentrancyAttack {
    ReentrancyExample private reentrancyExample;
    constructor(address _reentrancyExample) {
        reentrancyExample = ReentrancyExample(_reentrancyExample);
    }

    function attack() public {
        reentrancyExample.canBeReentered();
    }

    fallback() external {
        if(reentrancyExample.enteredCount() < 2) {
            reentrancyExample.canBeReentered();
        }
    }
}