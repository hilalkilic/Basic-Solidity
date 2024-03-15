//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample {

    uint256 public result;

    receive() external payable {  // takes only the empty tx 
        result = 1;
    }

    fallback() external payable { //takes transaction if it has data, may take the empty tx as well
        result=2;
    }
}

