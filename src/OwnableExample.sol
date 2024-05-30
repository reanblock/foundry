// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract OwnableExample is Ownable {
    constructor(address initialOwner) Ownable(initialOwner) {}

    function anyoneCanCall() public pure returns(bool) {
        return true;
    }

    function onlyOwnerCanCall() public view onlyOwner returns(bool) {
        return true;
    }
}