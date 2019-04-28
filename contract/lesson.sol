pragma solidity ^0.5.0;
//标准的代币：以太坊ERC20标准，所以的钱包，交易所，方便的统一的接口去支持所有的代币，我转账用什么方法等。 
//https://eips.ethereum.org/EIPS/eip-20 
//https://www.jianshu.com/p/a5158fbfaeb9 
//name：返回代币的名字 
//symbol：代币的简写 
//decimals：返回代币的小数点位 
//totalSupply:代币的总供应量 
//balanceOf:输入地址，可以获取该地址代币的余额。 
//transfer:转移代币 
//transferFrom:一个地址转移到另外一个地址,允许合约代表您转移代币
//approve：批准_spender账户从自己的账户转移_value个token。可以分多次转移 
//allowance：被委托多少个代币 
//Events:事件 
//transfer:转币发出的时候，发出这个事件 
//approval:委托的行为发出的时候
contract ERC20Interface{
    string public name;
    string public symbol;
    uint8 public decimals;
    uint public totalSupply;

    function transfer(address _to, uint256 _value) public returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
    function approve(address _spender, uint256 _value) public returns (bool success);
    function allowance(address _owner, address _spender) public view returns (uint256 remaining);
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

//继承ERC20Interface
contract ERC20 is ERC20Interface{

    mapping(address => uint) public balanceOf_new;
    mapping(address => mapping(address => uint)) internal allowed; 

    constructor() public{
        name = "AYF Token";
        symbol = "ATF";
        decimals = 0;
        totalSupply = 100000000;
        balanceOf_new[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success){
        //接收者_to 不能为0
        require(_to != address(0));
        //转出地址余额一定要大于，转出的代币数量
        require(balanceOf_new[msg.sender] >= _value);
        //uint的大小是256，如果大小超出256 需要错误处理
        require(balanceOf_new[_to] + _value >= balanceOf_new[_to]);
        balanceOf_new[msg.sender] -= _value;
        balanceOf_new[_to] += _value;
        emit Transfer(msg.sender , _to, _value);
        success = true;
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        // 必须用到approve 由发起调用人扣除_from账户代币
        // 接收者_to 不能为0
        require(_to != address(0));
        // 转出地址余额一定要大于，转出的代币数量
        require(balanceOf_new[_from] >= _value);
        // uint的大小是256，如果大小超出256 需要错误处理
        require(balanceOf_new[_to] + _value >= balanceOf_new[_to]);
        // 由发起调用人扣除_from账户代币必须大于_value
        require(allowed[_from][msg.sender] >= _value);
        
        balanceOf_new[_from] -= _value;
        balanceOf_new[_to] += _value;
        emit Transfer(msg.sender , _to, _value);
        success = true;
    }
    function approve(address _spender, uint256 _value) public returns (bool success){
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        success = true;
    }
    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return allowed[_owner][_spender];
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}