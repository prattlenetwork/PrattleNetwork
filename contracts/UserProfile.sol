pragma solidity ^0.4.0;

import "./Owned.sol";
import "./Post.sol";
import "./Users.sol";

contract UserProfile is Owned {
    string public username;
    string public picture;
    string public pictureType;
    string public description;

    uint public numberOfPosts = 0;
    uint public numberOfLikes = 0;

    Users usersContract;

    event Posted(Post post, uint timestamp);
    event PictureChanged(string picture, string pictureType);
    event DescriptionChanged(string description);
    event NameChanged(string name);

    constructor(string name, Users users) public {
        username = name;
        usersContract = users;
    }

    function setPicture(string ipfsHash, string ipfsType) onlyOwner public {
        require(bytes(ipfsHash).length > 0);
        require(bytes(ipfsType).length > 0);
        picture = ipfsHash;
        pictureType = ipfsType;
        emit PictureChanged(picture, pictureType);
    }

    function setDescription(string newDescription) onlyOwner public {
        require(bytes(newDescription).length > 0);
        description = newDescription;
        emit DescriptionChanged(newDescription);
    }

    function setName(string newName) onlyOwner public {
        require(bytes(newName).length > 0);
        username = newName;
        emit NameChanged(newName);
    }

    function post(string text, string ipfs, string ipfsType) onlyOwner public returns (Post) {
        Post newPost = new Post(text, ipfs, ipfsType);
        newPost.transferOwnership(msg.sender);
        numberOfPosts++;
        emit Posted(newPost, now);
        usersContract.postPublicly(newPost, now);
        return newPost;
    }
}
