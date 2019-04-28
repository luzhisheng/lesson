pragma solidity ^0.5.0;

// 构造函数：合约创建初始化的时候，构造函数也可以提供参数 
// 视图函数：view 修饰函数的关键字 
// 纯函数：pure既不会读取状态变量，也不会修改状态变量 
// 回退函数：无名函数，当我智能合约需要接受以太币，要实现回退函数

contract Test {
    uint internal data; //状态变量

    // 构造函数
    constructor(uint a) public{
        uint dada = a;
    }

    event EVENTA(uint a);

    // 视图函数
    function testView(uint dada) public view returns(uint){
        //dada = 1;
        uint data = 1;
        return dada;
    }

    // 纯函数
    function testpure() public pure returns(uint){
        //dada = 1;
        // return 1 + 2 + data 
        // pure 函数不能读取，改变状态变量
        return 1 + 2;
    }

    // 回退函数 一个合约如果要接收以太币，必需带上payable
    // 调用合约没有匹配到对应函数是，会被动调用回退函数
    function () external payable{
        emit EVENTA(1);//触发事件
    }
}

contract Caller{
    function callTest(Test test) public payable{
       address(test).send(1 ether);
    }
}