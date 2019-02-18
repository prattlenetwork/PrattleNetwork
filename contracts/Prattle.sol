pragma solidity ^0.4.0;

import "./Owned.sol";
import "./Users.sol";

contract Prattle is Owned {

    Users public users;
    constructor() public {
        users = new Users();
    }

}
