pragma solidity 0.8.24;

interface IFrameMakerFactory {
    struct InitParams {
        address owner;
        uint256 createFee; // basis points
        uint256 mintFee; // basis points
        address implementation;
    }

    struct Frame { 
        uint256 maxSupply;
        uint256 priceWif;
        uint256 priceWifout;
        address creator;
        address priceToken;
        address gateToken;
        string tokenURI;
        string name;
        string symbol;
    }
}