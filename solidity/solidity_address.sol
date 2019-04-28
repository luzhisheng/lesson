pragma solidity ^0.5.0;

contract AddTest {
    
    function deposit() public payable {

    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function transferEther(address payable towho) public {
        towho.transfer(10);
    }
}