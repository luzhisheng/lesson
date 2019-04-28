pragma solidity ^0.5.0;

// This is a test Contract 

contract Test {
    uint a;
    int256 b = -20;
    int256 c = 30;
    
    function testadd() public view returns (int) {
        if (b > c) {
            return b + c;
        } else if (b == c) {
            return b * c;
        } else {
            return  b >> 2;
        }
    }
    
    function testadd1() public view returns (int) {
        return b << 2;
    }
    
    function testadd2() public view returns (int) {
        return b / 2;
    }
    
}