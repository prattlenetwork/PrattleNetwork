pragma solidity ^0.4.0;

import "./Post.sol";
import "./UserProfile.sol";

contract Users {
    mapping(address => UserProfile) public userProfileOf;
    uint public numberOfUsers;

    event Posted(Post post, uint timestamp);
    event RegisterSuccess(address user, address profile);

    constructor() public {
        numberOfUsers = 0;
    }

    function registerUser(string userName) public {
        require(address(userProfileOf[msg.sender]) == address(0));
        require(bytes(userName).length > 0);
        UserProfile profile = new UserProfile(userName, this);
        profile.transferOwnership(msg.sender);
        userProfileOf[msg.sender] = profile;
        numberOfUsers++;
        emit RegisterSuccess(msg.sender, profile);
    }


    function postPublicly(Post post, uint timestamp) public {
        require(userProfileOf[post.owner()] == msg.sender);
        emit Posted(post, timestamp);
    }

}
