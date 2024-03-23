pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";import "./interfaces/IFrameMakerFactory.sol";
import "./interfaces/IFrameToken.sol";
import "./libraries/FrameLib.sol"; // Import the library

// @title Frame Token
// @notice 
contract FrameToken is IFrameToken, ERC721, ERC721Enumerable {
    // Variables //////////////
    FrameLib.Frame public frame; // Use the struct from the library
    IFrameMakerFactory public factory;
    uint256 nextTokenId;

    constructor(
        FrameLib.Frame memory f
    ) ERC721(f.name, f.symbol) {
        factory = IFrameMakerFactory(msg.sender);
        frame.maxSupply = f.maxSupply;
        frame.priceWif = f.priceWif;
        frame.priceWifout = f.priceWifout;
        frame.creator = f.creator;
        frame.gateToken = f.gateToken;
        frame.tokenURI = f.tokenURI;
        frame.name = f.name;
        frame.symbol = f.symbol;
    }

    function buy() external payable {
        uint256 fee = 0;
        uint256 price = 0;
        FrameLib.Frame memory f = frame;
        
        require(totalSupply() < f.maxSupply, "FrameToken: max supply reached");

        // Determine price of the token
        if (IERC721(f.gateToken).balanceOf(msg.sender) >= 0) {
            price = f.priceWif;
        } else {
            price = f.priceWifout;
        }
        require(msg.value >= price, "FrameToken: insufficient payment");

        nextTokenId += 1;
        _mint(msg.sender, nextTokenId);

        // Collect Payment
        fee = (price * factory.mintFee()) / 1e4;
        payable(factory.getFeeRecipient()).transfer(fee);
        payable(f.creator).transfer(price - fee);
    }

    function getFrame() external view returns (FrameLib.Frame memory f) {
        f = frame;
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(
        address to,
        uint128 amount
    ) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(to, amount);
    }

    function maxSupply() external view override returns (uint256) {
        return frame.maxSupply;
    }

    function remainingSupply() external view returns (uint256) {
        return frame.maxSupply - totalSupply();
    }

    receive() external payable {}
}