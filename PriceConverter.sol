//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; 
// this is the interface, compiling this gives the ABI of the contract

library PriceConverter {


     function getPrice() internal view returns(uint256) {// data feed (price feed) is what we need to get the pricing information)
    //ABI of the contract (a summary of the contract)
    //Address of the contract aggregator (ETH/USD address on the ethereum datafeeds for the network of our choosing)
    //0x694AA1769357215DE4FAC081bf1f309aDC325306
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    (,int256 answer,,,) = priceFeed.latestRoundData();
    //ETH in terms of USD
    //3000.00000000
    return uint256(answer*1e10);
    }

    function getConversionRate(uint ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount)/1e18;
        return ethAmountInUSD; 

    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();

    }
}