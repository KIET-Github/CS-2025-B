# NFT Marketplace

## Overview
This is a decentralized NFT Marketplace built using **Node.js, Next.js, React, and Solidity**. The platform allows users to mint, buy, and sell NFTs securely while integrating **MetaMask** for authentication and transactions. It operates on the **Polygon Amoy Test Network**.

## Features
- **NFT Minting**: Users can create and mint their own NFTs.
- **Marketplace Functionality**: Buy and sell NFTs on the platform.
- **MetaMask Integration**: Secure wallet authentication and transactions.
- **Smart Contract Deployment**: Written in Solidity and deployed on Polygon Amoy Test Network using Remix IDE.
- **Fast UI with Next.js**: Server-side rendering for better performance.

## Tech Stack
- **Frontend**: React, Next.js
- **Backend**: Node.js
- **Blockchain**: Solidity, Polygon Amoy Test Network
- **Wallet Integration**: MetaMask

## Installation & Setup
### Prerequisites
Ensure you have the following installed:
- [Node.js](https://nodejs.org/)
- [MetaMask Wallet](https://metamask.io/)
- [Remix IDE](https://remix.ethereum.org/) for Solidity development

### Clone the Repository
```sh
git clone https://github.com/ayushm0807/NFT-ArtHub.git
cd NFT-ArtHub
```

### Install Dependencies
```sh
npm install
```

### Configure Environment Variables
Create a `.env` file in the root directory and add:
```
NEXT_PUBLIC_PINATA_API_KEY=
NEXT_PUBLIC_PINATA_SECRET_API_KEY=
NEXT_PUBLIC_NFT_MARKETPLACE_ADDRESS=
```

### Run the Development Server
```sh
npm run dev
```
Visit `http://localhost:3000` to see the marketplace in action.

## Smart Contract Deployment
1. **Write and Compile Contracts** in Remix IDE.
2. **Deploy to Polygon Amoy Testnet** using Remix and MetaMask.
3. **Get the Contract Address** and update `.env`.

## MetaMask Configuration
To interact with the marketplace, add the **Polygon Amoy Test Network** to MetaMask:
- **Network Name**: Polygon Amoy Testnet
- **RPC URL**: `https://rpc-amoy.polygon.technology/`
- **Chain ID**: `80002`
- **Currency Symbol**: POL
- **Explorer**: `https://amoy.polygonscan.com/`

## Contributing
Feel free to contribute! Fork the repo, create a feature branch, and submit a pull request.

## License
This project is licensed under the MIT License.

## Contact
For any queries, reach out via [ayushm0807@gmail.com](mailto:ayushm0807@gmail.com).

