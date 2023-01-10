// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract Test721 is ERC721 {
    using Strings for uint256;
    using Counters for Counters.Counter;

    struct Metadata {
        string name;
        string image;
    }

    Counters.Counter private _tokenIds;
    mapping(uint256 => Metadata) private _metadatas;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {

    }

    function mint(string memory _name, string memory _image) external {
        require(bytes(_name).length != 0 && bytes(_image).length != 0, "Invalid param");
        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();
        _mint(msg.sender, tokenId);
        Metadata memory data = Metadata(_name, _image);
        _metadatas[tokenId] = data;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        Metadata memory data = _metadatas[tokenId];
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"image":"', data.image,'",',
                '"external_url":"",',
                '"description":"",',
                '"name": "', data.name, '",',
                '"attributes":[]',
            '}'
        );

        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }
}