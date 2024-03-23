// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {FrameMakerFactory} from "../src/FrameMakerFactory.sol";
import {FrameToken} from "../src/FrameToken.sol";
import {FrameLib} from "../src/libraries/FrameLib.sol";


contract Create is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address factoryAddress = vm.envAddress("FACTORY_ADDRESS");
        address creator = vm.envAddress("CREATOR_ADDRESS");
        address gateToken = vm.envAddress("GATE_TOKEN_ADDRESS");
    
        FrameLib.Frame memory f;
        f.maxSupply = 100;
        f.priceWif = 0.0025 ether;
        f.priceWifout = 0.005 ether;
        f.creator = creator;
        f.gateToken = gateToken;
        f.tokenURI = "test";
        f.name = "test";
        f.symbol = "test";


        vm.startBroadcast(deployerPrivateKey);
        FrameMakerFactory factory = FrameMakerFactory(factoryAddress);
        address frameToken = factory.createFrame(f);
        vm.stopBroadcast();

        console.log("FrameMakerFactory deployed at: ", frameToken);
    }
}
