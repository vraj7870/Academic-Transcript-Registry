// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//contract for On-chain identity verification (credential hash registry):Multi-credential, issuer registry,access control, event logging

contract IdentityRegistry {

    //Struct for a credential
    struct Credential{
        address issuer;
        bytes32 credentialHash;
        bool valid;
        uint256 issuedAt;
        string comment;
    }
    //mapping: user =>credentialHash =>Credential
    mapping(address => mapping(bytes32=>Credential)) public credentials;

    //mapping :allowed issuers (eg: universities, kyc companies)
    mapping (address=>bool) public isIssuer;

    //deployer / owner (admin of contract)
    address public owner;

    //Event for off-chain tracking 
    event IssuerAdded (address issuer);
    event CredentialRegistered(address indexed user , address indexed issuer , bytes32 credentialHash , string comment);
    event CredentialRevoked(address indexed user , address indexed issuer, bytes32 credentialHash);

    //Modifier: restrict action to contract owner
    modifier onlyOwner(){
        require(msg.sender == owner, "Not owner");
        _;
    }
    //Modifier: restrict credential creation to trusted issuers
    modifier onlyIssuer(){
        require(isIssuer[msg.sender], "Not an allowed issuer");
        _;
    }
    //Constructor: set contract deployer as owner and first issuer
    constructor(){
        owner = msg.sender;
        isIssuer[msg.sender]=true;
        emit IssuerAdded(msg.sender);
    }

    //Owner can add new trusted issuers
    function  addIssuer(address issuer) external onlyOwner{
        isIssuer[issuer] = true;
        emit IssuerAdded(issuer);
    }
    //Register a credential with a comment(issuer only)
    function registerIdentity(address user, bytes32 credentialHash, string calldata comment) external onlyIssuer{
        credentials[user][credentialHash] = Credential({
            issuer:msg.sender,
            credentialHash:credentialHash,
            valid:true,
            issuedAt:block.timestamp,
            comment:comment
        });
        emit CredentialRegistered(user, msg.sender, credentialHash, comment);
    }
    // Revoke credential (issuer only can revoke their own credential)
    function revokeIdentity(address user, bytes32 credentialHash) external {
        require(credentials[user][credentialHash].issuer == msg.sender, "Can only revoke your issued credential");
        credentials[user][credentialHash].valid = false;
        emit CredentialRevoked(user, msg.sender, credentialHash);
    }

    // Verify if user has valid credential (by hash)
    function verifyCredential(address user, bytes32 credentialHash) external view returns (bool) {
        return credentials[user][credentialHash].valid;
    }

    // Get credential details
    function getCredential(address user, bytes32 credentialHash) external view returns (
        address issuer, bool valid, uint256 issuedAt, string memory comment
    ) {
        Credential memory cred = credentials[user][credentialHash];
        return (cred.issuer, cred.valid, cred.issuedAt, cred.comment);
    }
}