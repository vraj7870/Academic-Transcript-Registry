// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract IdentityRegistry {
    address public owner;
    mapping(address => bool) public isVerified;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function registerIdentity(address user) public onlyOwner {
        isVerified[user] = true;
    }

    function verifyIdentity(address user) public view returns (bool) {
        return isVerified[user];
    }

    function revokeIdentity(address user) public onlyOwner {
        isVerified[user] = false;
    }
}
