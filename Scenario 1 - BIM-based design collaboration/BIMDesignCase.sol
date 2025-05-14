// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

import "./SCFlowBIMDesignCase.sol";

contract BIMDesignCase is SCFlowBIMDesignCase
{
    //Data type definition

    //Roles in state variables
    address PC_component_Supplier = 0x87AAADffD97956D64815B5e4a82423351B5C52c2;
    address General_contractor = 0x74f92067F666BAB099612D97BCD224dDE5356c57;
    address Quality_inspection_office = 0x320babFC88a67607A57E29A129B32aBF27DA0c55;

    //Roles in modifiers
    modifier OnlyPC_component_Supplier(){
        require(msg.sender == PC_component_Supplier," Only PC component Supplier can call this function.");
        _;
    }
    modifier OnlyGeneral_contractor(){
        require(msg.sender == General_contractor," Only General contractor can call this function.");
        _;
    }
    modifier OnlyQuality_inspection_office(){
        require(msg.sender == Quality_inspection_office," Only Quality inspection office can call this function.");
        _;
    }

    // set participants
    /*function setPC_component_Supplier(string memory strAddress) 
    public
    {
        PC_component_Supplier = address(strAddress);
    }*/


    //Functions
    //, uint actualCompletionDate)returns(uint)
    function StartEvent(string memory puid) 
        public
        inProcessFlow(puid, TaskName.StartEvent, TaskStatus.Ongoing)
        OnlyGeneral_contractor()
    {
        changeTaskName(puid, TaskName.StartEvent, TaskName.Place_order, "Place_order");
        //return (block.timestamp)
    }

    function Place_order(string memory puid)
    public
    OnlyGeneral_contractor()
    inProcessFlow(puid, TaskName.Place_order, TaskStatus.Ongoing)
    {
        changeTaskName(puid, TaskName.Place_order, TaskName.Receive_order, "Receive_order");
    }

    function Receive_order(string memory puid)
    public
    OnlyPC_component_Supplier()
    inProcessFlow(puid, TaskName.Receive_order, TaskStatus.Ongoing)
    {
        changeTaskName(puid, TaskName.Receive_order, TaskName.Make_production_plan, "Make_production_plan");
    }

    function Make_production_plan(string memory puid)
    public
    OnlyPC_component_Supplier()
    inProcessFlow(puid, TaskName.Make_production_plan, TaskStatus.Ongoing)
    {
        changeTaskName(puid, TaskName.Make_production_plan, TaskName.Manufacture_PC_components, "Manufacture_PC_components");
    }

    function Manufacture_PC_components(string memory puid)
    public
    OnlyPC_component_Supplier()
    inProcessFlow(puid, TaskName.Manufacture_PC_components, TaskStatus.Ongoing)
    {
        changeTaskName(puid, TaskName.Manufacture_PC_components, TaskName.Submit_samples_for_quality_inspection, 
        "Submit_samples_for_quality_inspection");
        // Handle parallel gateway:
        addNewCurrentTask(puid, TaskName.Store_PC_components, "Store_PC_components");
    }

    function Store_PC_components(string memory puid)
    public
    OnlyPC_component_Supplier()
    inProcessFlow(puid, TaskName.Store_PC_components, TaskStatus.Ongoing)
    {
        changeTaskNameStatus(puid, TaskName.Store_PC_components, TaskName.Prepare_PC_components_delivery, "Event_Wait", TaskStatus.WaitForCondition);
    }

    function Submit_samples_for_quality_inspection(string memory puid)
    public
    OnlyPC_component_Supplier()
    inProcessFlow(puid, TaskName.Submit_samples_for_quality_inspection, TaskStatus.Ongoing)
    {
        changeTaskName(puid, TaskName.Submit_samples_for_quality_inspection, 
        TaskName.Inspect_and_control_the_quality, "Inspect_and_control_the_quality");
    }

    function Inspect_and_control_the_quality(string memory puid, bool isQualified)
    public
    OnlyQuality_inspection_office()
    inProcessFlow(puid, TaskName.Inspect_and_control_the_quality, TaskStatus.Ongoing)
    {
        if(isQualified)
        {
            changeTaskName(puid, TaskName.Inspect_and_control_the_quality, 
            TaskName.Issue_quality_certificate, "Issue_quality_certificate");
        }
        else
        {
            changeTaskName(puid, TaskName.Inspect_and_control_the_quality, 
            TaskName.Require_quality_improvement, "Require_quality_improvement");
        }
    }

    function Issue_quality_certificate(string memory puid)
    public
    OnlyQuality_inspection_office()
    inProcessFlow(puid, TaskName.Issue_quality_certificate, TaskStatus.Ongoing)
    {
        changeTaskName(puid, TaskName.Issue_quality_certificate, 
        TaskName.Store_PC_components, "Store_PC_components");
    }

    function Require_quality_improvement(string memory puid)
    public
    OnlyQuality_inspection_office()
    inProcessFlow(puid, TaskName.Require_quality_improvement, TaskStatus.Ongoing)
    {
        changeTaskName(puid, TaskName.Require_quality_improvement, 
        TaskName.Make_production_plan, "Make_production_plan");
    }
}