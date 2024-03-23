// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {FrameMakerFactory} from "../src/FrameMakerFactory.sol";
import {FrameLib} from "../src/libraries/FrameLib.sol";


contract FrameMakerDeploy is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        FrameLib.Factory memory f;
        f.owner = vm.envAddress("OWNER");
        f.createFee = 100;
        f.mintFee = 100;

        console.log("Deploying FrameMakerFactory...");
        console.log("Owner: ", address(f.owner));
        console.log("Create Fee: ", f.createFee);
        console.log("Mint Fee: ", f.mintFee);

        vm.startBroadcast(deployerPrivateKey);
        FrameMakerFactory factory = new FrameMakerFactory(f);
        vm.stopBroadcast();

        console.log("FrameMakerFactory deployed at: ", address(factory));
    }
}
