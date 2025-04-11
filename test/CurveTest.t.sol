pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol"; 

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

interface IStableswapPool {
    // def add_liquidity(amounts: uint256[N_COINS], min_mint_amount: uint256):
    function add_liquidity(
        uint256[3] calldata amounts,
        uint256 min_mint_amount
    ) external;

    // def exchange(i: int128, j: int128, dx: uint256, min_dy: uint256):
    function exchange(
        int128 i,
        int128 j,
        uint256 dx,
        uint256 min_dy
    ) external; 

    function coins(
        uint256 arg0
    ) external view returns (address);
}

contract CurveTest is Test {

    using SafeERC20 for IERC20;

    uint256 constant UINT_MAX = 2**256-1;

    address alice = makeAddr("alice");

    address public usdcWhale = 0x47ac0Fb4F2D84898e4D9E7b4DaB3C24507a6D503;

    address public dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;    // i = 0 
    address public usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;   // i = 1
    address public usdt = 0xdAC17F958D2ee523a2206206994597C13D831ec7;   // i = 2

    // curve 3pool
    // https://curve.fi/dex/ethereum/pools/3pool/deposit/
    address public pool = 0xbEbc44782C7dB0a1A60Cb6fe97d0b483032FF1C7;

    function setUp() public virtual {
        vm.createSelectFork("mainnet", 22_243_800); 

        // need to prank a usdc whale account because the USDC token uses an unconventional 
        // balance storage slot preventing deal cheat from working!
        vm.startPrank(usdcWhale);
        IERC20(usdc).transfer(alice, 10_000 * 1e6);
        vm.stopPrank();

        // can use deal for dai and usdt
        deal(dai, alice, 10_000 * 1e18);
        deal(usdt, alice, 10_000 * 1e6);
    }

    function test_exchange() public {  
        vm.startPrank(alice);

        IERC20(dai).approve(pool , UINT_MAX);

        // exchange 1000 dai (i=0) for usdc (j=1)
        // def exchange(i: int128, j: int128, dx: uint256, min_dy: uint256):
        IStableswapPool(pool).exchange(0, 1, 1000 ether , 0); 
        vm.stopPrank();   
    }

    function test_tokens() public {
        assertEq(IStableswapPool(pool).coins(0), address(dai));
        assertEq(IStableswapPool(pool).coins(1), address(usdc));
        assertEq(IStableswapPool(pool).coins(2), address(usdt));

        assertEq(IERC20(dai).balanceOf(alice), 10_000 * 1e18);
        assertEq(IERC20(usdc).balanceOf(alice), 10_000 * 1e6);
        assertEq(IERC20(usdt).balanceOf(alice), 10_000 * 1e6);
    }

    function test_addLiquidity() public {
        vm.startPrank(alice);

        IERC20(usdc).approve(pool, UINT_MAX);

        uint256[3] memory depositAmounts = [uint256(0), uint256(1_000 * 1e6), uint256(0)];
        IStableswapPool(pool).add_liquidity(depositAmounts, 0);

        vm.stopPrank();
    }
}