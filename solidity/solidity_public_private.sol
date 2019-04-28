pragma solidity ^0.5.0;

// solidity 可见性 
// public 公开函数是合约接口的一部分，可以通过内部，或者消息来进行调用。对于public类型的状态变量，会自动创建一个访问器。函数默认可见性是public。 
// private 私有函数和状态变量仅在当前合约中可以访问，在继承的合约内，不可访问。
// external 外部函数是合约接口的一部分，只能使用消息调用
// internal 函数和状态变量只能通过内部访问，如在当前合约中调用，或继承的合约里调用。状态变量默认的可见性是internal

contract Test3 {
    uint internal data;
    
    uint public data2;

    function f(uint a) pure public returns (uint b) {
        return b + 1 + a;
    }

    function setdata(uint a) internal{
        data = a;
    }

    function exsetdata(uint a) external{
        data = a;
    }

    function testsetdata() public{
        setdata(1);
        this.exsetdata(1);
    }
    
    function abc() public{
        testsetdata();
        this.testsetdata();
    }
}

contract D{
    function readData() public{
        Test3 test3 = new Test3();
        test3.exsetdata(1);
        test3.testsetdata();
    }
}

contract Test2 is Test3{

    
    function setdata(uint a) internal{
        data = a;
        data2 = a;
    }
}

