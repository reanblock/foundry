// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {OwnableExample} from "../src/OwnableExample.sol";

interface IOwnable {
    // errors to test
    error OwnableUnauthorizedAccount(address account);
    // events to test
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
}

contract OwnableExampleTest is Test, IOwnable {
    OwnableExample public ownableExample;
    address public deployer = makeAddr("deployer");
    address public initialOwner = makeAddr("initialOwner");
    function setUp() public {
        vm.prank(deployer);
        ownableExample = new OwnableExample(initialOwner);
    }

    function test_ownerSet() public {
        // the deployer should NOT be the owner!
        assert(deployer != ownableExample.owner());
        // the initialOwner should be set to the owner :) 
        assertEq(initialOwner, ownableExample.owner());
    }

    function test_transferOwnership() public {
        address newOwner = makeAddr('newOwner');
        // check topic1 and topic2 and the emitter address is ownableExample
        vm.expectEmit(true, true, false, false, address(ownableExample));
        emit OwnershipTransferred(initialOwner, newOwner);
        vm.prank(initialOwner);
        ownableExample.transferOwnership(newOwner);
        // check the new owner is updated
        assertEq(newOwner, ownableExample.owner());
    }

    function test_transferOwnershipError() public {
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, address(this)));
        ownableExample.transferOwnership(address(0x12));
    }

    function test_anyoneCanCallFunction() public {
        ownableExample.anyoneCanCall();
        vm.prank(deployer);
        ownableExample.anyoneCanCall();
        vm.prank(initialOwner);
        ownableExample.anyoneCanCall();
    }

    function test_onlyOwnerCanCallFunction() public {
        // calling from this contract will revert
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, address(this)));
        bool ret1 = ownableExample.onlyOwnerCanCall();
        assertEq(ret1, false);

        // calling from a non owner account such as the deployer will revert
        vm.prank(deployer);
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, deployer));
        bool ret2 = ownableExample.onlyOwnerCanCall();
        assertEq(ret2, false);

        // calling as the owner - all should be good, no revert and function returns true
        vm.prank(initialOwner);
        bool ret3 = ownableExample.onlyOwnerCanCall();
        assertEq(ret3, true);
    }
}