pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdopthion{
    Adoption adoption = Adoption(DeployedAddresses.Adoption());

    //测试返回的id
    function testUserCanAdoption() public{
        uint re_id = adoption.adopt(8);
        uint expected = 8;
        Assert.equal(re_id, expected, "领养成功后id是8");
    }

    //测试领养的地址
    function testGetAddressAdoption() public{
        //当我们用测试合约去测试时，那么测试合约的地址就是领养的地址
        address adopters = adoption.adopters(8);
        address expected = address(this);
        Assert.equal(adopters, expected, "领养成功地址错误");
    }

    //测试所有的领养者
    function testGetAdoption() public{
        address[16] memory arry_adopters = adoption.getAdopters();
        address expected = address(this);
        Assert.equal(arry_adopters[8], expected, "所有的领养者错误");
    }
}