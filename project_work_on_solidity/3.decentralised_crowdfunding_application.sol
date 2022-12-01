//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;
contract CrowdFunding
{
    //These all are the state variables used in our smart contract
    mapping(address=>uint) public Contributors;
    address public Manager;
    uint public MinimumContribution;
    uint public Deadline;
    uint public Target;
    uint public CollectedAmount;
    uint public NoofContributors;

    struct RequestAmount
    {
        //Details of the cause
        string Description;
        address payable Recipient;
        uint valueofAmount;
        bool isAmountRecieved;
        uint NoofVoters;
        mapping(address=>bool) Voters;
    }
    mapping(uint=>RequestAmount) public RequestAmounts;
    uint public NoofRequestedAmounts;

    constructor(uint _Target,uint _Deadline)
    {
        Target = _Target;
        Deadline = block.timestamp + _Deadline;
        MinimumContribution = 100 wei;
        Manager = msg.sender;
    }

    function SendEther() public payable
    {
        require(block.timestamp < Deadline, "Deadline has passed");
        require(msg.value >=MinimumContribution,"Minimum Contribution is not met");

        if(Contributors[msg.sender] == 0)
        {
            NoofContributors++;
        }

        Contributors[msg.sender] =Contributors[msg.sender] + msg.value;
        CollectedAmount = CollectedAmount + msg.value;
    }

    function getContractBalance() public view returns(uint)
    {
        return address(this).balance;
    }

    function RefundAmount() public
    {
        require(block.timestamp < Deadline && CollectedAmount < Target);
        require(Contributors[msg.sender] > 0);
        address payable User = payable(msg.sender);
        User.transfer(Contributors[msg.sender]);
        Contributors[msg.sender] = 0;
    }

    modifier OnlyManager()
    {
        require(msg.sender == Manager,"Only Manager can call this Function");
        _;
    }

    function CreateRequest(string memory _Description,address payable _Recipient,uint _ValueofAmount) public OnlyManager
    {
        RequestAmount storage NewRequest = RequestAmounts[NoofRequestedAmounts];
        NoofRequestedAmounts++;
        NewRequest.Description = _Description;
        NewRequest.Recipient = _Recipient;
        NewRequest.valueofAmount = _ValueofAmount;
        NewRequest.isAmountRecieved = false;
        NewRequest.NoofVoters = 0;
    }

    function VoteRequest(uint _RequestNo) public
    {
        require(Contributors[msg.sender] > 0,"You must be a Contributor to Vote the Type of Request");
        RequestAmount storage ThisvoteRequest = RequestAmounts[_RequestNo];
        require(ThisvoteRequest.Voters[msg.sender]==false,"You have already Voted");
        ThisvoteRequest.Voters[msg.sender] = true;
        ThisvoteRequest.NoofVoters++;
    }  

    function MakePayment(uint _RequestNo) public OnlyManager
    {
        require(CollectedAmount>=Target);
        RequestAmount storage ThisvoteRequest = RequestAmounts[_RequestNo];
        require(ThisvoteRequest.NoofVoters > NoofContributors/2,"Majority of Contributors does not support");
        ThisvoteRequest.Recipient.transfer(ThisvoteRequest.valueofAmount);
        ThisvoteRequest.isAmountRecieved = true;       
    }
}