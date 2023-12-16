// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    /*
    This can be run using echidna as follows:

    docker run -it -v `pwd`:/src ghcr.io/crytic/echidna/echidna bash -c "solc-select install 0.8.13 && solc-select use 0.8.13 && echidna src/src/counter.sol"

    Or you can drop into the echidna container bash session and run the bash commands manually:

    docker run --rm -it -v `pwd`:/src ghcr.io/crytic/echidna/echidna
    */
    function echidna_check_number() public view returns (bool) {
        return(number >= 0);
    }

    receive() external payable {}
}
