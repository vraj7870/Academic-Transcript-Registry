// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract IdentityRegistry {
    address public owner;
    mapping(address => bool) public isVerified;

    constructor() {
        owner = msg.sender;
    }

  

    function register(address user) public onlyOwner {
        isVerified[user] = true;
    }

 

    function revoke(address user) public onlyOwner {
        isVerified[user] = false;
    }
    function revokeidt(address user) public onlyOwner {
        isVerified[user] = false;
    }
}


