// SPDX-License-Identifier: Unlicenced
pragma solidity 0.8.30;
contract TokenContract {
address public owner;
uint256 public constant TOKEN_PRICE = 5 ether;
struct Receivers {
string name;
uint256 tokens;
}
mapping(address => Receivers) public users;
modifier onlyOwner(){
require(msg.sender == owner);
_;
}
constructor(){
owner = msg.sender;
users[owner].tokens = 100;
}
function double(uint _value) public pure returns (uint){
return _value*2;
}
function register(string memory _name) public{
users[msg.sender].name = _name;
}
function giveToken(address _receiver, uint256 _amount) onlyOwner public{
require(users[owner].tokens >= _amount);
users[owner].tokens -= _amount;
users[_receiver].tokens += _amount;
}
//function to buy tokens with ether
function buyToken() public payable {
    require(msg.value >= TOKEN_PRICE, "Not enough Ether sent");
    uint tokenstoBuy = msg.value / TOKEN_PRICE;
    require(users[owner].tokens >= tokenstoBuy, "Owner has not enough Tokens");
    users[owner].tokens -= tokenstoBuy;
    users[msg.sender].tokens += tokenstoBuy;
}
function contractBalance() public view returns (uint256) {
    return address(this).balance;
}
}
