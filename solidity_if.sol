pragma solidity ^0.5.0;

// 控制结构 

contract Test3 {
    
    function testqwhile() public pure returns (uint, uint) {
        uint i = 0;
        uint sumfodd = 0;
        uint sumEven = 0;

        while(true){
            i ++;
            
            if (i > 10){
                break;
            }

            if (i % 2 == 0){
                sumfodd += i;
            }else{
                sumEven += i;
            }
        }
        
        sumfodd = sumfodd > 20 ? sumfodd + 20 : sumfodd;

        return (sumfodd, sumEven);
    }
}