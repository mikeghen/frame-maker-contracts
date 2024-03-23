pragma solidity 0.8.24;

import "./IFrameMakerFactory.sol";

// @title Frame Token
// @notice 
contract FrameToken is ERC721 {

    // Variables //////////////
    IFrameMakerFactory.FrameParams public frame;
    IFrameMakerFactory public factory;
    uint256 nextTokenId;

    function initialize(FrameMarkerFactory.Frame memory f) {
        factory = IFrameMarketFactory(msg.sender);
        frame.maxSupply = f.maxSupply;
        frame.priceWif = f.priceWif;
        frame.priceWifout = f.priceWifout;
        frame.creator = f.creator;
        frame.priceToken = f.priceToken;
        frame.gateToken = f.gateToken;
        frame.tokenURI = f.tokenURI;
    }

    function mint() {
        IFrameMakerFactory.Frame memory f = frame;
        require(totalSupply() < f.maxSupply);

        address recipient = msg.sender;
        uint256 fee = 0;
        uint256 price = 0;

        // Determine price of the token
        if (IERC721(f.gateToken).balanceOf(msg.sender) >= 0) {
            price = f.priceWif;
        } else {
            price = f.priceWifout;
        }

        nextTokenId += 1;
        mint(msg.sender, nextTokenId);

        // Collect Payment
        IERC20(f.priceToken).transferFrom(msg.sender, address(this), price);
        fee = price * factory.mintFee / 1e4;
        IERC20(f.priceToken).transfer(factory.owner, fee);
        IERC20(f.priceToken).transfer(f.creator, price - fee);
    }

}