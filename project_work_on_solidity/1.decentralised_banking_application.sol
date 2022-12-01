//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
contract ANBank
{
    mapping(address=>uint) balances;
    function getbalance() public view returns(uint)
    {
        return balances[msg.sender];
    }
    function deposit() public payable
    {
        balances[msg.sender]=balances[msg.sender]+msg.value;
    }
    function widraw(uint _amount) public
    {
        balances[msg.sender]=balances[msg.sender]-_amount;
        payable(msg.sender).transfer(_amount);
    }
    function transfer(address _to,uint _amount) public
    {
        balances[msg.sender]=balances[msg.sender]-_amount;
        balances[_to]=balances[_to]+_amount;
    }


}
