pragma solidity ^0.8.6;

abstract contract ERC20Token{

function name() public view returns (string);
function symbol() public view returns (string);
function decimals() public view returns (uint8);
function totalSupply() public view returns (uint256);
function balanceOf(address _owner) public view returns (uint256 balance);
function transfer(address _to, uint256 _value) public returns (bool success);
function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
function approve(address _spender, uint256 _value) public returns (bool success);
function allowance(address _owner, address _spender) public view returns (uint256 remaining);

event Transfer(address indexed _from, address indexed _to, uint256 _value);
event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

contract Owned{
    address public owner;
    address public newOwner;

    event OwnershipTransferred(address indexed _from, address index _to);

    constructor(){
        owner = msg.sender;
    }

    function transferOwnership(address _to) public{
        require(msg.sender == owner);
        newOwner = _to;
    }

    function acceptOwnership() public{
        require(msg.sender == newOwner);
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}

contract Token is ERC20Token, Owned{

    string public _symbol;
    string public _name;
    uint public _decimal;
    uint public _totalSupply;
    address public _minter;

    mapping(address => uint) balances;

    constructor(){
        _symbol = "Tk";
        _name = "Token";
        _decimal = 0;
        _totalSupply = 100;
        //_minter = add your account address; address that all initial currency will be sent to
    
        balances[_miner] = _totalSupply;
        emit Transfer(address(0), _minter, _totalSupply);
    }

    function name() public override view returns (string){
        return _name;
    }

    function symbol() public override view returns (string){
        return _symbol;
    }

    function decimals() public override view returns (uint8){
        return _decimal;
    }

    function totalSupply() public override view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address _owner) public override view returns (uint256 balance){
        return balances[_owner];
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success){
        require(balances[_from] >= _value);
        balances[_from] -= _value;
        balamces[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function transfer(address _to, uint256 _value) public override returns (bool success){
        return transferFrom(msg.sender, _to, _value);
    }
    
    //Function that aproves somebody else to spend value from your account
    //Since returns true function does nothing
    function approve(address _spender, uint256 _value) public override returns (bool success){
        return true;
    }

    //Third parties allowed to spend money from other peoples wallets
    //Since returns 0 no one is allowed to spend money from others peoples wallets
    function allowance(address _owner, address _spender) public override view returns (uint256 remaining){
        return 0;
    }

    function mint(uint amount) public returns (bool){
        require(msg.sender == _minter);
        balances[_minter] += amount;
        _totalSupply += amount;
        return true;
    }



}
