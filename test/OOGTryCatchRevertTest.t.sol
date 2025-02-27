// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Test, console2} from "forge-std/Test.sol";

contract InnerContract {
    uint256 public value;
    
    // Function that will be called externally
    function innerFunction() external {
        // Do some gas-intensive computation
        for(uint i = 0; i < 1_000; i++) {
            value += i;
        }
    }
}

contract OuterContract {
    InnerContract public inner;
    bool public stateChanged;

    constructor() {
        inner = new InnerContract();
    }
    
    // example NOT USING try..catch at all (just a direct call to innerFunction)
    function exampleDirectCall() external {
        // Change the state before the call
        stateChanged = true;

        // call to innerFunction will use up all of the gas sent to it (63/64)
        inner.innerFunction();

        // There was an OOG revert so stateChanged will be reverted back to false by the EVM
    }

    // example using try..catch WITHOUT explicit revert call
    function exampTryCatchWITHOUTRevertCall() external {
        // Change the state before the call
        stateChanged = true;

        try inner.innerFunction() {
            // There was an OOG revert in innerFunction ...
        } catch {
            // ... however, the state is not reverted by the EVM since essentially 
            // the revert is 'caught' and does not bubble up any further
        }
    }

    // example using try..catch WITH explicit revert call
    function exampleTryCatchWITHRevertCall() external {
        // Change the state before the call
        stateChanged = true;

        try inner.innerFunction() {
            // There was an OOG revert in innerFunction ...
        } catch {
            // always call revert to ensure state is reverted
            revert("innerFunction did something bad");
        }
    }
}

contract OOGTryCatchRevertTest is Test {
    OuterContract public outer;

    function setUp() public {
        outer = new OuterContract();
    }

    function test_exampleDirectCall() public {
        // here we expect the outer function to revert...
        vm.expectRevert(); 
        outer.exampleDirectCall{gas: 100_000}();
        // outer function state NOT changed because EVM reverted (EvmError: OutOfGas -> EvmError: Revert)
        assertEq(outer.stateChanged(), false);
    }

    function test_exampTryCatchWITHOUTRevertCall() public {
        // in this example the outer function will not revert becuase the revert is caught in the try..catch statement
        outer.exampTryCatchWITHOUTRevertCall{gas: 100_000}();
        // unfortunately the state in the outer contract is not reverted
        assertEq(outer.stateChanged(), true);
    }

    function test_exampleTryCatchWITHRevertCall() public {
        vm.expectRevert(); 
        outer.exampleTryCatchWITHRevertCall{gas: 100_000}();
        
        assertEq(outer.stateChanged(), false);
    }
}