// SPDX License: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "./interfaces/IFrameMakerFactory.sol";
import "./interfaces/IFrameToken.sol";
import "./FrameToken.sol";
import "./libraries/FrameLib.sol";

contract FrameMakerFactory is IFrameMakerFactory, Ownable {

    // Variables ////////////
    mapping(address => address) public userFrames;
    mapping(address => address) public frameUsers;
    address public frameTokenImplementation; 
    uint256 public mintFee;
    uint256 public createFee;

    constructor(FrameLib.Factory memory factory) Ownable(factory.owner) {
        mintFee = factory.mintFee;
        createFee = factory.createFee;
    }

    function createFrame(FrameLib.Frame memory frame) external returns (address frameToken) {
        frameToken = address(new FrameToken(frame));
        userFrames[frame.creator] = frameToken;
        frameUsers[frameToken] = frame.creator;
    }

    function getFrame(address creator) external view returns (address frameToken) {
        frameToken = userFrames[creator];
    }

    function getCreator(address frameToken) external view returns (address creator) {
        creator = frameUsers[frameToken];
    }

    function getFrameInfo(address frameToken) external view returns (FrameLib.Frame memory frame) {
        frame = IFrameToken(frameToken).getFrame();
    }

    function getFeeRecipient() external view returns (address) {
        return owner();
    }
 
}