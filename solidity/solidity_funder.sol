pragma solidity ^0.5.0;

contract AddTest {

    //结构体---》自定义类型
    struct Funder {
        address addr;
        uint amount;
    }

    Funder funder;

    //初始化结构体
    function newFunder() public {
        funder = Funder({addr: msg.sender, amount: 10});
    }

    //映射类型
    mapping(address => uint) public balances;

    function updateBalance(uint newBalance) public {
        balances[msg.sender] = newBalance;
    }
}