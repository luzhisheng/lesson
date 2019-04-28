pragma solidity ^0.4.0;

import "solidity_for_import.sol";

// this is a contract

contract Test{
    uint a;
    // bool boola = true;
    // bool boolb = false;

    // function testname1() public return(bool){
    //     return boola && boolb;
    // }

    // function testname2() public return(bool){
    //     return boola || boolb;
    // }

    int256 b = 20;
    int256 c = 30;

    function testadd() public return(int){
        if (b+c){
            return b + c;
        }else if (b == c){
            return b * c;
        }else{
            return b << 2;
        }
        return b + c;
    }

    function setA(uint x) public {
        a = x
        emit Set_A()
    }

    event Set_A(uint a);

    struct Position{
        int lat;
        int lng;
    }

    address public ownerAddr;

    modifier owner(){
        require(msg.sender == owerAddr);
        _;
    }
}