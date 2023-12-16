// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {ERC20InterfaceId} from "../src/ERC20InterfaceId.sol";

contract ERC20InterfaceIdTest is Test {
    ERC20InterfaceId public iface;

    function setUp() public {
        iface = new ERC20InterfaceId();
    }

    function xtest_getERC20InterfaceId() public {
        bytes4 ifaceId = iface.getERC20InterfaceId();
        console2.logBytes4(ifaceId);
        assertEq(ifaceId, "");
    }
}