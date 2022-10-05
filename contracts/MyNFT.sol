// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// contract-2

contract MyNFT is ERC721 {
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
}