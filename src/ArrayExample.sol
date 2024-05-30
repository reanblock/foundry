// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Arrays} from '@openzeppelin/contracts/utils/Arrays.sol';

contract ArrayExample {
    using Arrays for uint256[];
    uint256[] public arr = [0,1,2,3,4,8,20,99];

    function getArrLength() public returns(uint256) {
        return arr.length;
    }

    function getElementAtIndex(uint256 index) public view returns(uint256) {
        return arr[index];
    }

    function getUpperBoundStatic(uint256 element) public view returns(uint256) {
        return Arrays.findUpperBound(arr, element);
    }

    function getUpperBoundUsing(uint256 element) public view returns(uint256) {
        return arr.findUpperBound(element);
    }

    function getElementUnsafeAccess(uint256 pos) public view returns(uint256) {
        return arr.unsafeAccess(pos).value;
    }
}