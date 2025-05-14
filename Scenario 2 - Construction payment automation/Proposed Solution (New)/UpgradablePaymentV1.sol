/**
 *Submitted for verification at Etherscan.io on 2023-11-28
*/

/**
 *Submitted by Xuling Ye for verification at Etherscan.io on 2023-11-28
*Deployed to be executed by DataSmartContract at 0x3C7Dc8D92aC4B98A5F5C54d49d170dae90BD50A7
*/
/*
Website : https://xulingye.github.io/
*/
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

contract UpgradablePaymentV1 {

    string public currentExecutedFunc;
    string public historicalFuncs;
    address public currentDeployedAddr;

    address public Participant_Promisee;
    address public Participant_Validator;
    address public Participant_Promisor;
    string public processModelID = "UpgradablePaymentV1";

    function setupParticipants() public{
        Participant_Promisee = 0x87AAADffD97956D64815B5e4a82423351B5C52c2;
        Participant_Validator = 0x74f92067F666BAB099612D97BCD224dDE5356c57;
        Participant_Promisor = 0x320babFC88a67607A57E29A129B32aBF27DA0c55;
    }
    //Modifiers
    modifier  OnlyPromisee(){
        require(msg.sender == Participant_Promisee,"Only Promisee can access this function.");
        _;
    }
    modifier OnlyValidator(){
        require(msg.sender == Participant_Validator,"Only Validator can access this function.");
        _;
    }
    modifier OnlyPromisor(){
        require(msg.sender == Participant_Promisor,"Only Promisor can access this function.");
        _;
    }

    function StartEvent() public payable OnlyPromisee() 
    {
        bool isCorrect = compareStrings(currentExecutedFunc, "");
        require(isCorrect, "Cannot execute StartEvent");
        currentExecutedFunc = "StartEvent";
        historicalFuncs = addStrings(currentExecutedFunc, historicalFuncs);
    }
    function Submit_Payment_Application() public payable OnlyPromisee()
    {
        bool isCorrect = compareStrings(currentExecutedFunc, "StartEvent");
        require(isCorrect, "Cannot execute Submit_Payment_Application");
        currentExecutedFunc = "Submit_Payment_Application";
        historicalFuncs = addStrings(currentExecutedFunc, historicalFuncs);
    }
    function Confirm_Qualified_Work_Quantities() public payable OnlyValidator() 
    {
        bool isCorrect = compareStrings(currentExecutedFunc, "Submit_Payment_Application");
        require(isCorrect, "Cannot execute Confirm_Qualified_Work_Quantities");
        currentExecutedFunc = "Confirm_Qualified_Work_Quantities";
        historicalFuncs = addStrings(currentExecutedFunc, historicalFuncs);
    }
    function Issue_Payment_Valuation() public payable OnlyValidator() 
    {
        bool isCorrect = compareStrings(currentExecutedFunc, "Confirm_Qualified_Work_Quantities");
        require(isCorrect, "Cannot execute Issue_Payment_Valuation");
        currentExecutedFunc = "Issue_Payment_Valuation";
        historicalFuncs = addStrings(currentExecutedFunc, historicalFuncs);
    }
    function Issue_Payment_Certificate() public payable OnlyValidator() 
    {
        bool isCorrect = compareStrings(currentExecutedFunc, "Issue_Payment_Valuation");
        require(isCorrect, "Cannot execute Issue_Payment_Certificate");
        currentExecutedFunc =  "Issue_Payment_Certificate";
        historicalFuncs = addStrings(currentExecutedFunc, historicalFuncs);
    }
    function Finalize_Payment() public payable OnlyPromisor()
    {
        bool isCorrect = compareStrings(currentExecutedFunc, "Issue_Payment_Certificate");
        require(isCorrect, "Cannot execute Finalize_Payment");
        currentExecutedFunc =  "Finalize_Payment";
        historicalFuncs = addStrings(currentExecutedFunc, historicalFuncs);
    } 

    function addStrings(string memory left, string memory right) private pure returns (string memory){
        if(keccak256(abi.encodePacked(left)) != keccak256(abi.encodePacked("")))
        {   left = string.concat(left , " | ");}
        return string.concat(left , right);
    } 
    
    function compareStrings(string memory a, string memory b) private pure returns (bool) {
        return (keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b)));
    }
}