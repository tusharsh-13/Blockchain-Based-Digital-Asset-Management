// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DigitalAssetManagement {

    struct Asset {
        string assetName;
        string assetType;
        address owner;
        uint256 createdAt;
    }

    mapping(uint256 => Asset) public assets;
    uint256 public assetCount;

    event AssetRegistered(uint256 assetId, string assetName, address owner);
    event AssetTransferred(uint256 assetId, address from, address to);

    /// @notice Register a new digital asset
    /// @param _name Name of the asset
    /// @param _type Type of the asset (e.g., Image, Document, NFT, Music, etc.)
    function registerAsset(string memory _name, string memory _type) public {
        assetCount++;
        assets[assetCount] = Asset(_name, _type, msg.sender, block.timestamp);

        emit AssetRegistered(assetCount, _name, msg.sender);
    }

    /// @notice Transfer ownership of asset to a new owner
    /// @param _assetId The ID of the asset
    /// @param _newOwner Address of the new owner
    function transferAsset(uint256 _assetId, address _newOwner) public {
        require(_assetId > 0 && _assetId <= assetCount, "Invalid Asset ID");
        require(assets[_assetId].owner == msg.sender, "Only owner can transfer");

        address previousOwner = assets[_assetId].owner;
        assets[_assetId].owner = _newOwner;

        emit AssetTransferred(_assetId, previousOwner, _newOwner);
    }

    /// @notice Returns details of a particular asset
    /// @param _assetId The ID of the asset
    /// @return assetName, assetType, owner, createdAt
    function viewAsset(uint256 _assetId)
        public
        view
        returns (string memory, string memory, address, uint256)
    {
        require(_assetId > 0 && _assetId <= assetCount, "Invalid Asset ID");

        Asset memory asset = assets[_assetId];
        return (asset.assetName, asset.assetType, asset.owner, asset.createdAt);
    }
}
