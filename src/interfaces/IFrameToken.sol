// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../libraries/FrameLib.sol";

interface IFrameToken {
    function buy() external payable;
    function getFrame() external view returns (FrameLib.Frame memory frame);
    function maxSupply() external view returns (uint256);
    function remainingSupply() external view returns (uint256);
}