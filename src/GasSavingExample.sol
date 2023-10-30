// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// Run the test with the gas report option enabled!
// forge test -vvv --gas-report --mc GasSavingExampleTest
contract GasSavingExample {
    uint160 public packedVariables;

    function packVariables(uint80 x, uint80 y) external {
        packedVariables = uint160(x) << 80 | uint160(y);
    }

    function unpackVariables() external view returns (uint80, uint80) {
        uint80 x = uint80(packedVariables >> 80);
        uint80 y = uint80(packedVariables);
        return (x, y);
    }

    // Comment out the above and uncomment below
    // and check the gas costs of the two and you will
    // notice the bit shifting example above is cheaper!

    // uint80 public var1;
    // uint80 public var2;

    // function packVariables(uint80 x, uint80 y) external {
    //     var1 = x;
    //     var2 = y;
    // }

    // function unpackVariables() external view returns (uint80, uint80) {
    //     return (var1, var2);
    // }
}