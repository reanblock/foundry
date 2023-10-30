// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract StringStorage1 {
    // Uses only one slot
    // slot 0: 0x(len * 2)00...hex of (len * 2)(hex"hello")
    // Has smaller gas cost due to size.
    string public exampleString = "hello";

    function getString() public view returns (string memory) {
        return exampleString;
    }
}

contract StringStorage2 {
    // Length is more than 32 bytes. 
    // Slot 0: 0x00...(length*2+1).
    // keccak256(0x00): stores hex representation of "hello"
    // Has increased gas cost due to size.
    string public exampleString = "This is a string that is slightly over 32 bytes!";

    function getStringLongerThan32bytes() public view returns (string memory) {
        return exampleString;
    }
}