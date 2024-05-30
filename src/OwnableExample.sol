// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract OwnableExample is Ownable {
    constructor(address initialOwner) Ownable(initialOwner) {}
}