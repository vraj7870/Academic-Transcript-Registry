// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract IdentityRegistry {
    address public owner;
    mapping(address => bool) public isVerified;

    constructor() {
        owner = msg.sender;
    }

  

    function registerIdentity(address user) public onlyOwner {
        isVerified[user] = true;
    }

 

    function revokeIdentity(address user) public onlyOwner {
        isVerified[user] = false;
    }
}
