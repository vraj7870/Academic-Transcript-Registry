// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AcademicTranscriptRegistry {
    address public owner;

    struct Transcript {
        uint256 id;
        address student;
        string ipfsHash;
        address issuer;
        bool revoked;
        uint256 timestamp;
    }

    uint256 public transcriptCount = 0;
    mapping(uint256 => Transcript) public transcripts;
    mapping(address => uint256[]) public studentTranscripts;

    event TranscriptIssued(uint256 id, address student, string ipfsHash);
    event TranscriptRevoked(uint256 id, address revokedBy);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Issue a transcript for a student
    function issueTranscript(address student, string memory ipfsHash) public onlyOwner {
        require(student != address(0), "Invalid student address");
        require(bytes(ipfsHash).length > 0, "IPFS hash required");

        transcriptCount++;
        transcripts[transcriptCount] = Transcript({
            id: transcriptCount,
            student: student,
            ipfsHash: ipfsHash,
            issuer: msg.sender,
            revoked: false,
            timestamp: block.timestamp
        });

        studentTranscripts[student].push(transcriptCount);
        emit TranscriptIssued(transcriptCount, student, ipfsHash);
    }

    // Revoke a transcript
    function revokeTranscript(uint256 id) public onlyOwner {
        Transcript storage t = transcripts[id];
        require(t.id != 0, "Transcript not found");
        require(!t.revoked, "Already revoked");

        t.revoked = true;
        emit TranscriptRevoked(id, msg.sender);
    }

    // Verify if transcript hash matches and not revoked
    function verifyTranscript(uint256 id, string memory ipfsHash) public view returns (bool) {
        Transcript memory t = transcripts[id];
        if (t.revoked) return false;
        return (keccak256(bytes(t.ipfsHash)) == keccak256(bytes(ipfsHash)));
    }

    // Get all transcript IDs of a student
    function getStudentTranscripts(address student) public view returns (uint256[] memory) {
        return studentTranscripts[student];
    }
}
