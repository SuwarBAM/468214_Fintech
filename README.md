# 468214_Fintech
# Farm Management DApp

## Overview
The Farm Management DApp is a decentralized application that enables users to invest in farms by buying shares, updating harvest details, and claiming their share of the harvest. The application leverages the Ethereum blockchain to ensure transparency and security in all transactions.

## Technology Stack
- **Solidity**: Smart contract programming language
- **Remix IDE**: Development environment for writing and deploying smart contracts
- **Ethereum Blockchain**: Platform for deploying and executing smart contracts
- **MetaMask**: Browser extension for managing Ethereum accounts and interacting with decentralized applications

## Smart Contracts
### Farm.sol
Manages individual farm operations, including buying shares, updating harvests, and claiming harvests.

### FarmFactory.sol
Manages the creation and listing of farms and facilitates interactions between investors and farms.

## Main Functions
### Farm.sol
- **buyShares**: Allows users to buy shares in a farm.
- **updateHarvest**: Allows the farm owner to update the harvest details.
- **getShareholderHarvest**: Returns the harvest share for a shareholder.
- **claimHarvest**: Allows shareholders to claim their harvest.

### FarmFactory.sol
- **createFarm**: Creates a new farm.
- **buySharesInFarm**: Facilitates buying shares in a specific farm.
- **updateHarvestInFarm**: Updates the harvest for a specific farm.
- **claimHarvestInFarm**: Claims the harvest for a specific farm.
- **getFarms**: Lists all created farms.
- **getShareholderHarvestInFarm**: Gets harvest details for shareholders in a specific farm.

## Deployment and Testing
### Using Remix IDE
1. **Open Remix IDE**: Navigate to [Remix IDE](https://remix.ethereum.org/).
2. **Load Contracts**:
   - Create new files `Farm.sol` and `FarmFactory.sol` and copy the contract code from this repository.
3. **Compile Contracts**: Use the Solidity compiler in Remix to compile both contracts.
4. **Deploy Contracts**: 
   - Deploy the `FarmFactory` contract using the Remix deploy feature.
   - Ensure MetaMask is connected and set to the desired network (e.g., Ropsten Testnet or local Ganache).
5. **Interact with Contracts**: Use the Remix interface to call functions on the deployed contracts for testing.

### Example Deployment Workflow
1. **Create a Farm**: 
   - Call `createFarm` with parameters (e.g., 1000 shares, 10 Ether total value).
2. **Buy Shares**: 
   - Call `buySharesInFarm` with parameters (e.g., farm index 0, 10 shares).
3. **Update Harvest**: 
   - Call `updateHarvestInFarm` with parameters (e.g., farm index 0, "Wheat", 5 Ether value).
4. **Claim Harvest**: 
   - Call `claimHarvestInFarm` as a shareholder to claim your harvest share.

## Usage Workflow
1. **Create a Farm**: Farm owner creates a new farm by specifying total shares and total value.
2. **Buy Shares**: Investors buy shares in a listed farm.
3. **Update Harvest**: Farm owner updates the harvest details (crop type and value).
4. **Claim Harvest**: Shareholders claim their share of the harvest.
5. **View Information**: Users can view farms, their shares, and harvest details.

## Conclusion
The Farm Management DApp provides a decentralized and transparent platform for investing in farms and sharing harvests, leveraging the security and transparency of blockchain technology.

## License
This project is licensed under the MIT License
