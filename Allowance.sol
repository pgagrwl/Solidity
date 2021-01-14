pragma solidity 0.6.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract Allowance is Ownable{
    
    using SafeMath for uint ;
    
    event AllowanceChange(address indexed _forwho, address indexed _fromWhom, uint _oldamount, uint _newamount);
    
     mapping(address => uint) public allowance;    
    
    function addAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChange(_who, msg.sender , allowance[_who], _amount);
        allowance[_who]  =  _amount;
    }
    
    modifier ownerOrAllowed(uint _amount) {
        require((owner() ==msg.sender) || allowance[msg.sender] >= _amount, "You are not allowed!");
        _;
    }
    
    function reduceAllowance(address _who, uint _amount) internal {
        emit AllowanceChange(_who, msg.sender , allowance[_who] ,allowance[_who].sub(_amount));
        allowance[_who]  = allowance[_who].sub(_amount);
    }
}
