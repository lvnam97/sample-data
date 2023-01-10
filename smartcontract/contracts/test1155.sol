// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract Test1155 is ERC1155 {
    using Strings for uint256;
    using Counters for Counters.Counter;

    struct Metadata {
        string name;
        string image;
    }

    Counters.Counter private _tokenIds;
    mapping(uint256 => Metadata) private _metadatas;

    constructor() ERC1155("") {

    }

    function mint(string memory _name, string memory _image, uint256 amount) external {
        require(bytes(_name).length != 0 && bytes(_image).length != 0, "Invalid param");
        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();
        _mint(msg.sender, tokenId, amount, "");
        Metadata memory data = Metadata(_name, _image);
        _metadatas[tokenId] = data;
    }

    function uri(uint256 tokenId) public view virtual override returns (string memory) {
        require(tokenId <= _tokenIds.current(), "URI query for nonexistent token");
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