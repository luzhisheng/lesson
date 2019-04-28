pragma solidity ^0.5.0;


// 区块链是分布式的事务性数据库，区块链天生事务，没有中间状态！
// 错误处理
// assert 通常检查函数内部错误 
// require 合约状态变量是否满足条件，通常是外部合约条件

contract Sharer {

    function sendHalf(address payable addr) public payable returns(uint balance){
        require(msg.value % 2 == 0);
        uint balanceBeforeTranfer = address(this).balance;
        addr.transfer(msg.value / 2);
        assert(address(this).balance == balanceBeforeTranfer - msg.value / 2);

        return address(this).balance;
    }
}

