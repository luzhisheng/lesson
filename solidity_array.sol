pragma solidity ^0.5.0;

contract ArrayTest {
    uint[] public u = [1,2,3];
    string s = "abcdefg";

    function h() public view returns (uint){
        return bytes(s).length;
    }

    function f() public view returns (byte){
        return bytes(s)[1];
    }

    //动态创建memory数组
    function newM(uint len) public pure returns (uint) {
        uint[] memory a = new uint[](len);
        a[3] = 8;

        //bytes memory b = new bytes(len);
        
        g([uint(1), 2, 3]);

        return a.length;
    }
    
    //数组是参数的情况下
    function g(uint[3] memory _data) public pure returns (uint[3] memory){
        return _data;
    }
}

