pragma solidity ^0.5.0;

// This is a test Contract 

contract Test3 {
    uint a;
    int256 b = -20;
    int256 c = 30;
    
    function testadd3() public pure returns (int) {
        return 1 + 2;
    }
    
    function testadd4() public pure returns (string memory) {
        return "test";
    }
    
    function testadd5() public pure returns (bytes16) {
        return hex"001122FF";
    }
}