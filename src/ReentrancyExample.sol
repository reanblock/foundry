// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ReentrancyGuard} from '@openzeppelin/contracts/utils/ReentrancyGuard.sol';
import {Test, console} from "forge-std/Test.sol";

contract ReentrancyExample is ReentrancyGuard {
    uint256 public enteredCount;
    function canBeReentered() public returns(uint256) {
        // console.log("_reentrancyGuardEntered: ", _reentrancyGuardEntered());
        enteredCount++;
        msg.sender.call("");
    }

    function canNotBeReentered() public nonReentrant returns(uint256) {
        // console.log("_reentrancyGuardEntered: ", _reentrancyGuardEntered());
        enteredCount++;
        msg.sender.call("");
    }
}