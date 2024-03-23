// SPDX License: MIT
pragma solidity 0.8.24;


// @title Frame Maker Factory
// @notice 
contract FrameMakerFactory is IFrameMakerFactory, Ownable {
    
    // Variables ////////////
    mapping(address => address) public userFrames;
    mapping(address => address) public frameUsers;
    address public frameTokenImplementation; 
    uint256 public mintFee;
    uint256 public createFee

    constructor(InitParams memory params) {
        frameTokenImplementation = params.implementation;
        mintFee = params.mintFee;
        createFee = params.createFee;
    }

    function createFrame(Frame memory frameTokenImplementation) external returns (address) {
        Compensator compensator = new Compensator();       
        compensator.initialize(delegatee, delegateeName);
        compensators.push(address(compensator));
        delegateeToCompensator[delegatee] = address(compensator);
        return address(compensator);
    }

    function getCompensator(address delegatee) external view returns (address) {
        return delegateeToCompensator[delegatee];
    }

    function createFrame(Frame memory frame) {

    }

    function getFrameByUser(address user) {

    }

    function getUserByFrame(address frameToken) {

    }
 
}