// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

contract Farm {
    // Structure to store details of a shareholder
    struct Shareholder {
        uint256 shares; // Number of shares owned by the shareholder
        uint256 harvestShare; // Share of the harvest allocated to the shareholder
    }

    // Structure to store details of the harvest
    struct Harvest {
        string cropType; // Type of crop harvested
        string unit; // Unit of measurement for the harvest
        uint256 value; // Total value of the harvest
    }

    address public owner; // Address of the farm owner
    uint256 public totalShares; // Total number of shares in the farm
    uint256 public availableShares; // Number of shares available for purchase
    uint256 public totalValue; // Total value of the farm
    uint256 public shareCost; // Cost of each share
    Harvest public harvest; // Current harvest details

    // Mapping from shareholder address to Shareholder struct
    mapping(address => Shareholder) public shareholders;
    // Array to store all shareholder addresses
    address[] public shareholderAddresses;

    // Modifier to restrict functions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Constructor to initialize the farm with total shares and total value
    constructor(uint256 _totalShares, uint256 _totalValue) public {
        owner = msg.sender; // Set the owner to the contract deployer
        totalShares = _totalShares; // Set the total number of shares
        availableShares = _totalShares; // Set the available shares to total shares initially
        totalValue = _totalValue; // Set the total value of the farm
        shareCost = totalValue / totalShares; // Calculate the cost of each share
    }

    // Function to buy shares in the farm
    function buyShares(uint256 _numShares) public payable {
        require(_numShares > 0 && _numShares <= availableShares, "Invalid number of shares"); // Check for valid number of shares
        require(msg.value >= _numShares * shareCost, "Insufficient funds"); // Ensure sufficient funds are sent

        // Add the buyer to the shareholder addresses if they are not already a shareholder
        if (shareholders[msg.sender].shares == 0) {
            shareholderAddresses.push(msg.sender);
        }

        // Update the number of shares owned by the buyer
        shareholders[msg.sender].shares += _numShares;
        // Decrease the number of available shares
        availableShares -= _numShares;
    }

    // Function to update the harvest details
    function updateHarvest(string memory _cropType, string memory _unit, uint256 _value) public onlyOwner {
        // Set the new harvest details
        harvest = Harvest(_cropType, _unit, _value);

        // Distribute the harvest value among shareholders based on their shares
        for (uint256 i = 0; i < shareholderAddresses.length; i++) {
            address shareholderAddress = shareholderAddresses[i];
            Shareholder storage shareholder = shareholders[shareholderAddress];
            if (shareholder.shares > 0) {
                shareholder.harvestShare = (shareholder.shares * harvest.value) / totalShares;
            }
        }
    }

    // Function to get the harvest details for the calling shareholder
    function getShareholderHarvest() public view returns (string memory cropType, string memory unit, uint256 harvestShare) {
        Shareholder storage shareholder = shareholders[msg.sender];
        return (harvest.cropType, harvest.unit, shareholder.harvestShare);
    }

    // Function to claim the harvest for the calling shareholder
    function claimHarvest() public {
        Shareholder storage shareholder = shareholders[msg.sender];
        require(shareholder.harvestShare > 0, "No harvest to claim"); // Ensure the shareholder has a harvest share to claim
        uint256 amount = shareholder.harvestShare; // Get the harvest share amount
        shareholder.harvestShare = 0; // Reset the harvest share to 0
        payable(msg.sender).transfer(amount); // Transfer the harvest share amount to the shareholder
    }
}
