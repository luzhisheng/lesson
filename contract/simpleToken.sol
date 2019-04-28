pragma solidity ^0.5.0;

contract MyToken{
    //映射类型，定义一个变量报错每个地址余额
    mapping(address => uint) public balanceOf;

    //初始化代币供应量
    constructor(uint iniSupply) public payable{
        balanceOf[msg.sender] = iniSupply;
    }

    //代币的交易
    function transfer(address _to, uint _value) public{
        //转出地址余额一定要大于，转出的代币数量
        require(balanceOf[msg.sender] >= _value);
        //uint的大小是256，如果大小超出256 需要错误处理
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }
}