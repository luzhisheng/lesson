pragma solidity ^0.5.0;

// 输入输出参数：函数的返回值 
// 命名参数：限制要传入的参数的名字，只能传我已命名关键字参数。
// 参数解构：函数的返回值，用元祖的方式返回多个不同类型的值，同时赋值多个变量
contract Test {

    function SimpleInput(uint a, uint b) pure public returns(uint sum){
       return sum = a + b;
    }

    function jgsimpleInput(uint a, uint b) public pure returns(uint sum, uint mul){
        sum = a + b;
        mul = a * b;
    }

    function testSimpleInput() public pure returns(uint sum){
        sum = SimpleInput({a:1,b:2});
    }

    function jgtestSimpleInput() public pure returns(uint sum, uint mul){
        (sum, mul) = jgsimpleInput({a:1,b:2});
    }

    function f() pure public returns (uint, bool, uint) {
        return (7, true, 2);
    }

    function g() pure public returns (uint x, bool y, uint z){
       (x, y,z) = f();
       return (x, y, z);
    }
    
}