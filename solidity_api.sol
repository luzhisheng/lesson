pragma solidity ^0.5.0;

// solidity 提供的全局变量和函数
//  一、有关区块和交易 
//  1、msg.sender 交易发送者地址(address) 
//  2、msg.value 当前交易附带的以太币数量，单位wei （uint） 
//  3、block.coinbase 当前块的地址（address） 
//  4、block.difficulty当前区块的难度 （uint） 
//  5、block.number 当前区块的块号 （uint） 
//  6、block.timestamp 当前区块的unix时间戳 （uint） 
//  7、now 当前区块的unix时间戳 （uint） 
//  8、tx.gasprice 当前的交易的价格 （uint）

contract ArrayTest {

    constructor() public payable{
        
    }

    function testapi() public view returns(address){
        return msg.sender;
    }

    function testmsgvalue() public payable returns(uint){
        return msg.value;
    }

    function testmsgcoinbase() public payable returns(address){
        return block.coinbase;
    }

    function testmsgdifficulty() public payable returns(uint){
        return block.difficulty;
    }

    function testmsgnumber() public payable returns(uint){
        return block.number;
    }

    function testmsgtimestamp() public payable returns(uint){
        return block.timestamp;
    }

    function testmsgnow() public payable returns(uint){
        return now;
    }

    function testmsggasprice() public payable returns(uint){
        return tx.gasprice;
    }

}

