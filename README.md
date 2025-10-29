🎓 Academic Transcript Registry (On-Chain Verification System)

A decentralized Academic Transcript Registry that allows universities, students, and verifiers to securely issue, store, and verify academic records on the blockchain — ensuring authenticity, transparency, and tamper-proof verification.

🚀 Project Overview

Traditional academic transcript systems are prone to fraud, forgery, and time-consuming verification processes.
The Academic Transcript Registry (ATR) solves these issues using blockchain-based verification and smart contracts.

Each transcript is represented as an immutable record on-chain that can be verified by employers, institutions, or government agencies without third-party involvement.

🧠 Core Idea

Universities issue verified transcripts using their digital identity.

Students can claim, view, and share their verified transcripts.

Employers or Verifiers can check the authenticity of transcripts instantly through blockchain validation.

All data is stored securely using on-chain identifiers and IPFS (for document storage).

⚙️ Tech Stack
Layer	Technologies
Frontend	React.js / Next.js, Tailwind CSS
Backend	Node.js, Express
Smart Contracts	Solidity, Hardhat / Foundry
Blockchain	Ethereum / Polygon / Any EVM-compatible chain
Storage	IPFS / Filecoin for transcript files
Database (optional)	MongoDB / PostgreSQL for off-chain indexing
🧩 Key Features

🧾 On-chain Transcript Hashing: Each transcript’s hash is recorded on-chain to ensure immutability.

👩‍🎓 Student Ownership: Students control access to their credentials.

🏛️ University Verification: Only authorized institutions can issue or revoke transcripts.

🔍 Instant Verification: Third parties can verify authenticity using a transaction hash or QR code.

🌐 IPFS Integration: Transcript documents stored on decentralized file storage.

🔒 Secure Access: Encrypted data exchange between users and verifiers.

📁 Project Structure
Academic-Transcript-Registry/
│
├── contracts/           # Solidity smart contracts
├── backend/             # Express/Node.js backend
├── frontend/            # React or Next.js frontend
├── scripts/             # Deployment and verification scripts
├── package.json
├── hardhat.config.js
└── README.md

🧰 Setup Instructions
1. Clone the Repository
git clone https://github.com/<your-username>/Academic-Transcript-Registry.git
cd Academic-Transcript-Registry

2. Install Dependencies
npm install

3. Compile and Deploy Smart Contracts
npx hardhat compile
npx hardhat run scripts/deploy.js --network <network-name>

4. Start Backend Server
cd backend
npm start

5. Start Frontend
cd frontend
npm run dev

🧾 Smart Contract Overview
Function	Description
issueTranscript(address student, string ipfsHash)	Issue transcript and store IPFS hash
verifyTranscript(bytes32 transcriptHash)	Verify authenticity of a transcript
revokeTranscript(uint transcriptId)	Revoke a previously issued transcript
getTranscript(address student)	Retrieve transcript details for a student
🔒 Security & Access Control

Only whitelisted universities (verified by admin) can issue transcripts.

Students’ data and transcripts are linked to their on-chain wallets.

Hash-based verification ensures no private data is directly stored on-chain.



👥 Contributors

Project Lead: Vipin Raj
Institution: IIT Kharagpur
