// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./Farm.sol";

contract FarmFactory {
    // Array to store all farm instances
    Farm[] public farms;

    // Create a new farm
    function createFarm(uint256 _totalShares, uint256 _totalValue) public {
        Farm farm = new Farm(_totalShares, _totalValue);
        farms.push(farm);
    }

    // Buy shares in a specific farm
    function buySharesInFarm(uint256 _farmIndex, uint256 _numShares) public payable {
        require(_farmIndex < farms.length, "Invalid farm index");
        Farm farm = Farm(address(farms[_farmIndex]));
        farm.buyShares{value: msg.value}(_numShares);
    }

    // Update harvest details for a specific farm
    function updateHarvestInFarm(uint256 _farmIndex, string memory _cropType, uint256 _value) public {
        require(_farmIndex < farms.length, "Invalid farm index");
        Farm farm = Farm(address(farms[_farmIndex]));
        farm.updateHarvest(_cropType, _value);
    }

    // Claim harvest from a specific farm
    function claimHarvestInFarm(uint256 _farmIndex) public {
        require(_farmIndex < farms.length, "Invalid farm index");
        Farm farm = Farm(address(farms[_farmIndex]));
        farm.claimHarvest();
    }

    // Get list of all farm addresses
    function getFarms() public view returns (address[] memory) {
        address[] memory farmAddresses = new address[](farms.length);
        for (uint256 i = 0; i < farms.length; i++) {
            farmAddresses[i] = address(farms[i]);
        }
        return farmAddresses;
    }

    // Get harvest share of the caller in a specific farm
    function getShareholderHarvestInFarm(uint256 _farmIndex) public view returns (uint256 harvestShare) {
        require(_farmIndex < farms.length, "Invalid farm index");
        Farm farm = Farm(address(farms[_farmIndex]));
        return farm.getShareholderHarvest();
    }
}
