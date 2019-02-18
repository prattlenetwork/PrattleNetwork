pragma solidity ^0.4.24;

contract Owned {
    address public owner;

    event TransferredOwnership(address newOwner);

    constructor() public {
        owner = msg.sender;
    }
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner public {
        owner = newOwner;
        emit TransferredOwnership(newOwner);
    }
}
