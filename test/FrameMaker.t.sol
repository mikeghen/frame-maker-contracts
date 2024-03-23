// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {FrameMakerFactory} from "../src/FrameMakerFactory.sol";
import {FrameToken} from "../src/FrameToken.sol";
import {IFrameMakerFactory} from "../src/interfaces/IFrameMakerFactory.sol";
import {IFrameToken} from "../src/interfaces/IFrameToken.sol";
import {FrameLib} from "../src/libraries/FrameLib.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {
    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}


contract FrameMakerFactoryTest is Test {
    uint256 internal constant PRICE_WIF = 0.5 ether;
    uint256 internal constant PRICE_WIFOUT = 1 ether;
    FrameMakerFactory internal factory;
    address internal factoryOwner = makeAddr("factoryOwner");
    address internal creator1 = makeAddr("creator1");
    address internal creator2 = makeAddr("creator2");
    address internal buyer1 = makeAddr("buyer1");
    address internal buyer2 = makeAddr("buyer2");
    MockERC20 internal token;

    function setUp() public {
        token = new MockERC20("USDC", "USDC");

        vm.deal(buyer1, 10 ether);
        vm.deal(buyer2, 10 ether);

        FrameLib.Factory memory f;
        f.owner = factoryOwner;
        f.createFee = 100;
        f.mintFee = 100;

        factory = new FrameMakerFactory(f);
    }

    function _createFrame(address creator) internal returns (address) {
        FrameLib.Frame memory f;
        f.maxSupply = 100;
        f.priceWif = PRICE_WIF;
        f.priceWifout = PRICE_WIFOUT;
        f.creator = creator;
        f.gateToken = address(token);
        f.tokenURI = "test";
        f.name = "test";
        f.symbol = "test";

        vm.prank(creator1);
        return factory.createFrame(f);
    }

    function test_deploy() public view {
        assertEq(factory.owner(), factoryOwner);
        assertEq(factory.createFee(), 100); // basis points
        assertEq(factory.mintFee(), 100); // basis points
    }

    function test_createFrame() public {
        _createFrame(creator1);

        address frameToken = factory.getFrame(creator1);
        assertEq(factory.getCreator(frameToken), creator1);
        FrameLib.Frame memory frame = factory.getFrameInfo(frameToken);
        assertEq(frame.maxSupply, 100);
        assertEq(frame.priceWif, PRICE_WIF);
        assertEq(frame.priceWifout, PRICE_WIFOUT);
        assertEq(frame.creator, creator1);
        assertEq(frame.gateToken, address(token));
        assertEq(frame.tokenURI, "test");
        assertEq(frame.name, "test");
        assertEq(frame.symbol, "test");
    }

    function test_buyWithoutToken() public {
        _createFrame(creator1);

        address frameToken = factory.getFrame(creator1);
        IFrameToken ft = IFrameToken(frameToken);
        FrameLib.Frame memory frame = factory.getFrameInfo(frameToken);

        vm.prank(buyer1);
        ft.buy{value: frame.priceWifout}();

        uint256 fee = frame.priceWifout / 100;
        assertEq(payable(creator1).balance, frame.priceWifout - fee);
        assertEq(payable(factory.getFeeRecipient()).balance, fee);
    }

    function test_buyWithToken() public {
        _createFrame(creator1);

        token.mint(buyer1, 1);

        address frameToken = factory.getFrame(creator1);
        IFrameToken ft = IFrameToken(frameToken);
        FrameLib.Frame memory frame = factory.getFrameInfo(frameToken);

        vm.prank(buyer1);
        ft.buy{value: frame.priceWif}();

        uint256 fee = frame.priceWif / 100;
        assertEq(payable(creator1).balance, frame.priceWif - fee);
        assertEq(payable(factory.getFeeRecipient()).balance, fee);
    }

}
