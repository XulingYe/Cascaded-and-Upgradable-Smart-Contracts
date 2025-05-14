// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

contract DataSmartContract{

    string public currentExecutedFunc;
    string public historicalFuncs;

    address public linkedPSC;

    function setLinkedPSC(address psc) public{
        linkedPSC = psc;
    }

// format of funcName should be "functionName()"
    function executeTask(string memory funcName) public payable{
        (bool success, ) = payable(linkedPSC).delegatecall(abi.encodeWithSignature(funcName));
        require(success, "Delegate call failed");
    }
}
