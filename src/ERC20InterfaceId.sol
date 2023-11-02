// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC20InterfaceId {
    function getERC20InterfaceId() public pure returns(bytes4) {
        return type(IERC20).interfaceId;
    }
}