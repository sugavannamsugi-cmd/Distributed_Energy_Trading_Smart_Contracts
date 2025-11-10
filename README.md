# Distributed Energy Trading with Smart Contracts (Demo)

This repository contains a **minimal, working demo** for a distributed energy trading smart contract and a simple web UI to interact with it.

**Not production-ready.** This is intended for learning and prototyping.

## Contents
- `contracts/EnergyTrading.sol` - Solidity smart contract (simple offers & purchases)
- `hardhat/` - recommended Hardhat project files (instructions below)
- `frontend/index.html` - lightweight web UI using Ethers.js via CDN
- `README.md` - this file

## Quick setup (recommended: Hardhat local dev network)

Prerequisites:
- Node.js (16+)
- npm
- Git (optional)
- A local Ethereum node (Hardhat's in-memory network or Ganache)

Steps:
1. Create a project folder and copy these files, or clone this repo.
2. Initialize npm and install dependencies:
   ```
   npm init -y
   npm install --save-dev hardhat @nomiclabs/hardhat-ethers ethers
   ```
3. Create a minimal Hardhat config (see `hardhat.config.js.sample` included).
4. Start a local Hardhat node in one terminal:
   ```
   npx hardhat node
   ```
5. In another terminal deploy the contract using the sample deploy script:
   ```
   npx hardhat run --network localhost scripts/deploy.js
   ```
   Note the deployed contract address from the script output.

6. Open `frontend/index.html` in a browser (served from a simple static server or open file).  
   - The frontend expects a local Ethereum provider (MetaMask connected to localhost:8545) or you can modify the provider RPC URL in the JS.

## Frontend usage
- Connect MetaMask (or similar) to local node (http://127.0.0.1:8545).
- Enter values to create an offer: energy (Wh) and price (in ETH).
- Buy an offer by entering its ID and sending the exact ETH amount.

## Files of interest
- `contracts/EnergyTrading.sol` - contract code (see comments)
- `scripts/deploy.js` - sample Hardhat deploy script
- `frontend/index.html` - simple UI (uses Ethers.js via CDN)

## Notes & Security
This demo is intentionally simple:
- No dispute resolution, no oracle integration, no identity, no metering.
- Do NOT use for real-value trading without audits and secure infrastructure.

--- 
Happy prototyping! 🚀
