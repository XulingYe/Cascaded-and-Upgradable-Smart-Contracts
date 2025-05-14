// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

contract OldPaymentV2{
    string currentExecutedFunc;
    string historicalFuncs ="";
   function getCurrentExecutedFunc() public view returns(string memory)
    {   return currentExecutedFunc; }
    function getHistoricalFuncs() public view returns(string memory)
    {   return historicalFuncs;}

    function fInitialePayment() public {
        currentExecutedFunc = "fInitialePayment";
        historicalFuncs = addStrings(historicalFuncs , currentExecutedFunc);
    }
    function fValidatePayment() public {
        currentExecutedFunc = "fValidatePayment";
        historicalFuncs = addStrings(historicalFuncs , currentExecutedFunc);
    }
    function fDisbursePayment() public {
        currentExecutedFunc = "fDisbursePayment";
        historicalFuncs = addStrings(historicalFuncs , currentExecutedFunc);
    }
    function fCompletePayment() public {
        currentExecutedFunc = "fCompletePayment";
        historicalFuncs = addStrings(historicalFuncs , currentExecutedFunc);
    }

    function fDecidePaymentOption() public {
        currentExecutedFunc = "fDecidePaymentOption";
        historicalFuncs = addStrings(historicalFuncs , currentExecutedFunc);
    }

    function addStrings(string memory left, string memory right) private pure returns (string memory){
        if(keccak256(abi.encodePacked(left)) != keccak256(abi.encodePacked("")))
        {   left = string.concat(left , ", ");}
        return string.concat(left , right);
    } 
}
