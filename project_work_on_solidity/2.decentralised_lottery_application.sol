//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
contract Lottery
{
    address public manager;
    address payable[] public participants;
    constructor()
    {
        manager=msg.sender;
    }
    receive() payable external
    {
        require(msg.value==1 ether);
        participants.push(payable(msg.sender));
    }
    function getBalance() public view returns(uint)
    {
        require(msg.sender==manager);
        return address(this).balance;
    }
    function random() public view returns(uint)
    {
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }
    function selectWinner() public
    {
        require(msg.sender==manager);
        require(participants.length>=5);
        uint RandomWinner=random();
        address payable Winner;
        uint indexposition=RandomWinner %participants.length;
        Winner=participants[indexposition];
        Winner.transfer(getBalance());
        participants=new address payable[](0);
    }
}