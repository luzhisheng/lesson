pragma solidity ^0.5.0;

//宠物领养合约编写

contract Adoption{
    //定义领养者的地址，16地址
    address[16] public adopters;
    //处理领养
    function adopt(uint petId) public returns(uint){
        require(petId >= 0 && petId <= 15);
        adopters[petId] = msg.sender;
        return petId;
    }

    //得到所有领养者的信息
    function getAdopters() public view returns(address[16] memory){
        return adopters;
    }
}