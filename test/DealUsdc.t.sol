pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol"; 
import {IERC20} from "forge-std/interfaces/IERC20.sol";

contract DealUSDC is Test {
    address alice = makeAddr("alice");

    address public usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public usdcWhale = 0x47ac0Fb4F2D84898e4D9E7b4DaB3C24507a6D503;

    function setUp() public virtual {
        vm.createSelectFork("mainnet", 22_243_800); 

        // deal(usdc, alice, 10_000 * 1e6);
        vm.startPrank(usdcWhale);
        IERC20(usdc).transfer(alice, 10_000 * 1e6);
        vm.stopPrank();
    }

    function test_alice_has_usdc() public virtual {
        assertEq(IERC20(usdc).balanceOf(alice), 10_000 * 1e6);
        // console.log("working");
        // console.log("Alice USDC balance:", IERC20(usdc).balanceOf(alice));
    }
}