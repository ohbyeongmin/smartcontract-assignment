// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol"; 

// contract-2

contract MyNFT is ERC721Enumerable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    Counters.Counter private _tokenCount;
    uint private enableAt;

    constructor () ERC721("MyNFT", "MNT") {
        enableAt = block.timestamp;
    }

    modifier mintLimit() {
        if( block.timestamp > enableAt + 1 minutes ) {
            enableAt = block.timestamp;
            _tokenCount.reset();
        }
        if( _tokenCount.current() > 10 ) {
            revert("Exceeded production");
        }
        _;
        _tokenCount.increment();
    }

    function mint() external mintLimit {
        uint newId = _tokenIds.current();
        _tokenIds.increment();
        _mint(msg.sender, newId);
    }

    function tokenURI(uint256 tokenId) override public pure returns (string memory) {
        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="500%" fill="grey" /><text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">ohbyeongmin, obm</text></svg>';
        
        string memory output = string(abi.encodePacked(svg));
        
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Egg Head ', Strings.toString(tokenId), '", "description": "A new NFT collection", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));

        output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;
    }
}