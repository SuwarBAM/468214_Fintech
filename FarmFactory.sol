// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./Farm.sol"; // Import the Farm contract

contract FarmFactory {
    // Array to store all farm instances
    Farm[] public farms;

    // Function to create a new farm with total shares and total value
    function createFarm(uint256 _totalShares, uint256 _totalValue) public {
        Farm farm = new Farm(_totalShares, _totalValue); // Create a new Farm contract instance
        farms.push(farm); // Add the new farm to the farms array
    }

    // Function to buy shares in a specific farm
    function buySharesInFarm(uint256 _farmIndex, uint256 _numShares) public payable {
        require(_farmIndex < farms.length, "Invalid farm index"); // Ensure the farm index is valid
        Farm farm = Farm(address(farms[_farmIndex])); // Get the Farm contract instance
        farm.buyShares{value: msg.value}(_numShares); // Call the buyShares function on the specified farm
    }

    // Function to update the harvest in a specific farm
    function updateHarvestInFarm(uint256 _farmIndex, string memory _cropType, string memory _unit, uint256 _value) public {
        require(_farmIndex < farms.length, "Invalid farm index"); // Ensure the farm index is valid
        Farm farm = Farm(address(farms[_farmIndex])); // Get the Farm contract instance
        farm.updateHarvest(_cropType, _unit, _value); // Call the updateHarvest function on the specified farm
    }

    // Function to get the harvest details for a specific shareholder in a specific farm
    function getShareholderHarvestInFarm(uint256 _farmIndex) public view returns (string memory cropType, string memory unit, uint256 harvestShare) {
        require(_farmIndex < farms.length, "Invalid farm index"); // Ensure the farm index is valid
        Farm farm = Farm(address(farms[_farmIndex])); // Get the Farm contract instance
        return farm.getShareholderHarvest(); // Call the getShareholderHarvest function on the specified farm
    }

    // Function to claim the harvest for a specific shareholder in a specific farm
    function claimHarvestInFarm(uint256 _farmIndex) public {
        require(_farmIndex < farms.length, "Invalid farm index"); // Ensure the farm index is valid
        Farm farm = Farm(address(farms[_farmIndex])); // Get the Farm contract instance
        farm.claimHarvest(); // Call the claimHarvest function on the specified farm
    }

    // Function to get the list of farm addresses
    function getFarms() public view returns (address[] memory) {
        address[] memory farmAddresses = new address[](farms.length);
        for (uint256 i = 0; i < farms.length; i++) {
            farmAddresses[i] = address(farms[i]);
        }
        return farmAddresses;
    }
}
