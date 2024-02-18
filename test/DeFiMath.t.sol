// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {DeFiMath} from "../src/DeFiMath.sol";

contract DeFiMathTest is Test {
    DeFiMath public defimath;

    function setUp() public {
        defimath = new DeFiMath();
    }

    function test_getOutputAmountBasedOnInput() public view {
        uint256 inputAmount = 10 ether;
        uint256 inputReserves = 50723935511759605266242689; // 100 ether;
        uint256 outputReserves = 31195344978488074485161; //  50 ether;
        uint256 outputAmount = defimath.getOutputAmountBasedOnInput(inputAmount, inputReserves, outputReserves);

        // (wethToDeposit * currentPoolTokens ) / (currentWeth + wethToDeposit) = output

        // dy = (y - k) / (x + dx)
        uint256 numerator = inputAmount * outputReserves;
        uint256 denominator = inputReserves + inputAmount;
        uint256 expectedOut = numerator / denominator;

        console2.log("inputAmount", inputAmount);
        console2.log("Expected Output Amount", expectedOut);
        console2.log("Output Amount", outputAmount);
    }

    function test_CompoundInterest() public view {
        // FV = Future Value
        // PV = Present Vault
        // r = interest rate
        // n = number of years

        // FV = PV(1+r)**n

        uint256 principal = 10 ether;
        uint256 PRECISION = 1e4; //100_00; 10 000
        uint256 rate = 1000;
        uint256 n = 5;

        // uint256 fv = pv * ( (PRECISION + r ) ** n) / PRECISION;


        // Compound Interest formula: A = P(1 + r/n)^(nt)
        // A = the future value of the investment/loan, including interest
        // P = the principal investment amount (the initial deposit or loan amount)
        // r = the annual interest rate (in decimal: 10% = 0.1)
        // t = the time the money is invested or borrowed for, in years
        // n = the number of times that interest is compounded per year

        uint256 amount = principal * (PRECISION + rate / n) ** n;
        console2.log("amount: ", amount / PRECISION);
    }

}
