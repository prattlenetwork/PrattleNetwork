pragma solidity ^0.4.24;

import "./Owned.sol";

contract Post is Owned {
    string public text;
    string public ipfsFile;
    string public ipfsFileType;
    uint256 public timestamp;

    Post public parent;
    bool public isSharing = false;

    mapping(address => int) public ratings;
    uint public likes = 0;
    uint public dislikes = 0;
    uint public comments = 0;
    uint public shares = 0;

    event Shared(Post sharedBy, uint256 timestamp);
    event CommentPosted(Post post, uint256 timestamp);
    event Rated(address user, int rating);

    constructor(string message, string ipfs, string ipfsType) public {
        text = message;
        ipfsFile = ipfs;
        ipfsFileType = ipfsType;
        timestamp = now;
    }

    function rate(int newRating) public {
        require(newRating == - 1 || newRating == 0 || newRating == 1);
        if (ratings[msg.sender] == - 1) {
            dislikes -= 1;
        } else if (ratings[msg.sender] == 1) {
            likes -= 1;
        }
        ratings[msg.sender] = newRating;
        if (newRating == - 1) {
            dislikes += 1;
        } else if (newRating == 1) {
            likes += 1;
        }
        emit Rated(msg.sender, newRating);
    }

    function comment(Post post) public {
        require(msg.sender == address(post.owner()));
        post.setParent(this);
        comments += 1;
        emit CommentPosted(post, now);
    }

    function share(Post post) public {
        require(msg.sender == address(post.owner()));
        post.setParent(this);
        post.setSharing(true);

        shares += 1;
        emit Shared(post, now);
    }
    //only by new parent
    function setParent(Post post) public {
        require(msg.sender == address(post));
        parent = post;
    }
    //only by parent
    function setSharing(bool shared) public {
        require(msg.sender == address(parent));
        isSharing = shared;
    }

}
