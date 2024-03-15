//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

//Get funds from users
//Withdraw funds
//Set a minimum funding value in USD

import"./PriceConverter.sol";

error NotOwner();

contract FundMe {

    uint256 public constant MINIMUM_USD  = 50*1e18; // the constant keyword helps save gas
    address[] public funders;
    mapping(address=>uint256) public addressToAmountFunded;

    address public immutable i_owner; // the immutable keyword helps save gas

    modifier onlyOwner {
        //require(msg.sender == i_owner, "Sender is not owner."); // we could optimize the warning string, you do that by custom errors
        if(msg.sender != i_owner) {revert NotOwner();}
        _;                                                                                 
        // the underscore means to run the require statement first, and then the other codes

    }
    
    constructor(){
        i_owner=msg.sender;
    }


    function fund() public payable{

        //Want to be able to set a minimum fund amount in USD
        //1. How do we send ETH to this contract?

        require(msg.value >= MINIMUM_USD, "Didn't send enough!");//1e18==1*10**18=1000000000000000000
        
    }

    //basic for loop in solidity
    function witdraw()  public onlyOwner {
        //require(msg.sender==owner, "Sender is not owner.");   //we only want the person who is collecting the funds to be able to withdraw the funds
//what if there are a lot of functions for which we want the caller to be the owner? ===> modifier
                 /*(starting index, ending index, step amount)*/
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array
        funders = new address[](0);


        //actually withdraw the funds

               //transfer (takes 2300 gas, gives an error when exceeded)        
        //payable(msg.sender).transfer(address(this).balance);//

                //send (2300 gas, returns bool)
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "Send Failed");

        //call
        (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance} ("");
        require(callSuccess, "Call failed."); 

        //What if someone sends money to this contract without the fund function?
        // recieve, fallback

    }
    
    receive() external payable { 
        fund();
    }


//0x2e5C520dC92Fbb924ea4a79b86A3D07c7A211464
//0x2e5C520dC92Fbb924ea4a79b86A3D07c7A211464


//Lesson 4 Recap:  
// 1. Enums
// 2. Events
// 3. Try / Catch 
// 4. Function Selectors
// 5. abi.encode / decode
// 6. Hashing
// 7. Yul / Assembly 


}