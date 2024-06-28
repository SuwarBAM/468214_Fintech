// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

contract Farm {
    // Struct to store shareholder details
    struct Shareholder {
        uint256 shares;
        uint256 harvestShare;
    }

    // Struct to store harvest details
    struct Harvest {
        string cropType;
        uint256 value;
    }

    address public owner;
    uint256 public totalShares;
    uint256 public availableShares;
    uint256 public totalValue;
    uint256 public shareCost;
    Harvest public harvest;

    mapping(address => Shareholder) public shareholders;
    address[] public shareholderAddresses;

    // Modifier to restrict functions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Constructor to initialize the farm with total shares and value
    constructor(uint256 _totalShares, uint256 _totalValue) public {
        owner = msg.sender;
        totalShares = _totalShares;
        availableShares = _totalShares;
        totalValue = _totalValue;
        shareCost = _totalValue / _totalShares;
    }

    // Function to buy shares in the farm
    function buyShares(uint256 _numShares) public payable {
        require(_numShares > 0 && _numShares <= availableShares, "Invalid number of shares");
        require(msg.value >= _numShares * shareCost, "Insufficient funds");

        if (shareholders[msg.sender].shares == 0) {
            shareholderAddresses.push(msg.sender);
        }

        shareholders[msg.sender].shares += _numShares;
        availableShares -= _numShares;
    }

    // Function to update the harvest details
    function updateHarvest(string memory _cropType, uint256 _value) public onlyOwner {
        harvest = Harvest(_cropType, _value);

        for (uint256 i = 0; i < shareholderAddresses.length; i++) {
            address shareholderAddress = shareholderAddresses[i];
            Shareholder storage shareholder = shareholders[shareholderAddress];
            if (shareholder.shares > 0) {
                shareholder.harvestShare = (shareholder.shares * harvest.value) / totalShares;
            }
        }
    }

    // Function to get the harvest share of the calling shareholder
    function getShareholderHarvest() public view returns (uint256 harvestShare) {
        Shareholder storage shareholder = shareholders[msg.sender];
        return shareholder.harvestShare;
    }

    // Function to claim the harvest share
    function claimHarvest() public {
        Shareholder storage shareholder = shareholders[msg.sender];
        require(shareholder.harvestShare > 0, "No harvest to claim");
        uint256 amount = shareholder.harvestShare;
        shareholder.harvestShare = 0;
        payable(msg.sender).transfer(amount);
    }
}

