//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;
import "./5.ierc20.sol";
contract ERC20 is IERC20
{
    uint public totalSupply=21000000;
    mapping(address=>uint) public balanceOf;
    mapping(address=>mapping(address=>uint)) public allowance;
    string public name="MBDCoin";
    string public symbol="MBD";
    uint public decimals=18;

    constructor()
    {
        balanceOf[msg.sender]=totalSupply;
    }

    function transfer(address recipient,uint amount) external returns(bool)
    {
        balanceOf[msg.sender]=balanceOf[msg.sender]-amount;
        balanceOf[recipient]=balanceOf[recipient]+amount;
        emit Transfer(msg.sender,recipient,amount);
        return true;
    }
    function approve(address spender,uint amount) external returns(bool)
    {
        allowance[msg.sender][spender]=amount;
        emit Approval(msg.sender,spender,amount);
        return true;
    }
    function transferFrom(address sender,address recipient,uint amount) external returns(bool)
    {
        allowance[sender][msg.sender]=allowance[sender][msg.sender]-amount;
        balanceOf[sender]=balanceOf[sender]-amount;
        balanceOf[recipient]=balanceOf[recipient]+amount;
        emit Transfer(sender,recipient,amount);
        return true;
    }
    function mint(uint amount) external
    {
        balanceOf[msg.sender]=balanceOf[msg.sender]+amount;
        totalSupply=totalSupply+amount;
        emit Transfer(address(0),msg.sender,amount);

    }
    function burn(uint amount) external
    {
        balanceOf[msg.sender]=balanceOf[msg.sender]-amount;
        totalSupply=totalSupply-amount;
        emit Transfer(msg.sender,address(0),amount);
    }
}
