// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ArrayExample} from '../src/ArrayExample.sol';

contract ArrayExampleTest is Test {
    ArrayExample public arrayExample;
    function setUp() public {
        arrayExample = new ArrayExample();
    }

    function test_deployed() public {
        assert(address(arrayExample) != address(0x0));
    }

    function test_getArrayLength() public {
        assertEq(arrayExample.getArrLength(), 8);
    }

    function test_getElementAtIndexFunction() public {
        assertEq(arrayExample.getElementAtIndex(6),20);
    }

    function test_getUpperBoundStatic() public {
        assertEq(arrayExample.getUpperBoundStatic(8), 5);
    }

    function test_getUpperBoundUsing() public {
        assertEq(arrayExample.getUpperBoundUsing(8), 5);
    }

    function test_getElementUnsafeAccess() public {
        assertEq(arrayExample.getElementUnsafeAccess(7), 99);
    }

    function test_getElementUnsafeAccessOutOfRange() public {
        // the 'unsafe' access does not revert but returns 0
        assertEq(arrayExample.getElementUnsafeAccess(8), 0);
    }

    function test_getElementAtIndexFunctioReverts() public {
        vm.expectRevert(); //array out-of-bounds access
        arrayExample.getElementAtIndex(8);
    }

    function test_getElementUnsafeMemoryAccess() public {
        assertEq(arrayExample.getElementUnsafeMemoryAccess(1), 99);
    }
}