// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract RoundingErrorTest is Test {
    uint256 private constant CONVERSION = 1e12;

    function swapDAIForUSDC(uint256 usdcAmount) internal view returns (uint256 daiToTake) {
        uint256 daiToTake = usdcAmount / CONVERSION;
        // console.log("In swapDAIForUSDC: ", usdcAmount);
        // console.log("In swapDAIForUSDC: ", daiToTake);
        return daiToTake;
    }

    function test_swapDAIForUSDCRoundingError() public {
        uint256 dai = swapDAIForUSDC(100e6);
        console.log("You get DAI: ", dai);
    }
}