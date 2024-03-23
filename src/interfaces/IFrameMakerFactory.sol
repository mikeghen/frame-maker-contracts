pragma solidity 0.8.24;

interface IFrameMakerFactory {
    function createFee() external view returns (uint256);
    function mintFee() external view returns (uint256);
    function getFeeRecipient() external view returns (address);
}