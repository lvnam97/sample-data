//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract VNGCharacter is ERC721, AccessControl, ERC721Enumerable {
  using Strings for uint256;
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;
  bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

  mapping(uint256 => uint256) internal characters;
  mapping(uint256 => string) internal images;
  mapping(address => bool) public claimers;

  constructor() ERC721("VNGCharacter", "VNGC") {
    _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    _grantRole(MINTER_ROLE, msg.sender);
  }

  function _baseURI() internal pure override returns (string memory) {
    return "https://apinft.xwg.games/bscnft/";
  }

  function setCharacter(uint256 _tokenId, uint256 _gender, uint256 _hair, uint256 _eyeWear, uint256 _face, uint256 _outfit, string calldata _image) private {
    uint256 character = uint256(_gender);
    character |= _hair << 8;
    character |= _eyeWear << 16;
    character |= _face << 24;
    character |= _outfit << 32;
    characters[_tokenId] = character;
    images[_tokenId] = _image;
  }

  function getCharacter(uint256 _tokenId) public view returns (uint256 _gender, uint256 _hair, uint256 _eyeWear, uint256 _face, uint256 _outfit, string memory _image) {
    uint256 character = characters[_tokenId];
    _gender = uint256(uint8(character));
    _hair = uint256(uint8(character >> 8));
    _eyeWear = uint256(uint8(character >> 16));
    _face = uint256(uint8(character >> 24));
    _outfit = uint256(uint8(character >> 32));
    _image = images[_tokenId];
  }

  function getGenderAttribute(uint256 _index) public pure returns (string memory) {
      string[2] memory genders = ['male', 'female'];
      return genders[_index];
  }

  function getHairAttribute(uint256 _index) public pure returns (string memory) {
    string[8] memory hairs = ['ShortHairDreads01', 'ShortHairDreads02', 'ShortHairShaggyMullet', 'ShortHairTheCaesar', 'LongHairMiaWallace', 'LongHairStraight', 'LongHairCurvy', 'LongHairBigHair'];
    return hairs[_index];
  }

  function getEyewearAttribute(uint256 _index) public pure returns (string memory) {
    string[4] memory eyewears = ['Kurt', 'Prescription01', 'Round', 'Wayfarers'];
    return eyewears[_index];
  }

  function getFaceAttribute(uint256 _index) public pure returns (string memory) {
    string[4] memory faces = ['FM1', 'FM2', 'FM3', 'FM4'];
    return faces[_index];
  }

  function getOutfitAttribute(uint256 _index) public pure returns (string memory) {
    string[6] memory outfits = ['GraphicShirt', 'BlazerSweater', 'ShirtCrewNeck', 'Hoodie', 'BlazerShirt', 'CollarSweater'];
    return outfits[_index];
  }

  function getImage(uint256 _image) public pure returns (bytes memory) {
    return abi.encodePacked(_image);
  }

  function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        (uint256 _gender, uint256 _hair, uint256 _eyeWear, uint256 _face, uint256 _outfit, string memory _image) = getCharacter(tokenId);
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"image":"',_image,'",',
                '"external_url":"",',
                '"description":"",',
                '"name": "VNGCharacter #', tokenId.toString(), '",',
                '"animation_url":"",',
                '"attributes":[',
                '{',
                    '"att_id":"1",'
                    '"att_name":"Gender",'
                    '"value":"',getGenderAttribute(_gender),'",',
                    '"value_display":"',getGenderAttribute(_gender),'"',
                '},',
                '{',
                    '"att_id":"2",'
                    '"att_name":"Hair",'
                    '"value":"',getHairAttribute(_hair),'",',
                    '"value_display":"',getHairAttribute(_hair),'"',
                '},',
                '{',
                    '"att_id":"3",'
                    '"att_name":"Eyewear",'
                    '"value":"',getEyewearAttribute(_eyeWear),'",',
                    '"value_display":"',getEyewearAttribute(_eyeWear),'"',
                '},',
                '{',
                    '"att_id":"4",'
                    '"att_name":"Face",'
                    '"value":"',getFaceAttribute(_face),'",',
                    '"value_display":"',getFaceAttribute(_face),'"',
                '},',
                '{',
                    '"att_id":"5",'
                    '"att_name":"Outfit",'
                    '"value":"',getOutfitAttribute(_outfit),'",',
                    '"value_display":"',getOutfitAttribute(_outfit),'"',
                '}',
                ']',
            '}'
        );

        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }


  function hasClaimed(address _address) public view returns (bool) {
    return claimers[_address];
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl, ERC721Enumerable) returns (bool) {
    return super.supportsInterface(interfaceId);
  }

  function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
    super._beforeTokenTransfer(from, to, tokenId);
  }

  function mintNFT(uint8 _gender, uint8 _hair, uint8 _eyeWear, uint8 _face, uint8 _outfit, string calldata _image, bytes memory) public returns (uint256){
    claimers[msg.sender] = true;
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    setCharacter(newItemId, _gender, _hair, _eyeWear, _face, _outfit, _image);
    _mint(msg.sender, newItemId);

    return newItemId;
  }

  function mintNFTFor(address to, uint8 _gender, uint8 _hair, uint8 _eyeWear, uint8 _face, uint8 _outfit, string calldata _image, bytes memory) public returns (uint256){
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    setCharacter(newItemId, _gender, _hair, _eyeWear, _face, _outfit, _image);
    _mint(to, newItemId);

    return newItemId;
  }

  function mintBatchNFTFor(address to, uint8 _gender, uint8 _hair, uint8 _eyeWear, uint8 _face, uint8 _outfit, string[] calldata _images, uint256 count) public {
    for(uint i = 0; i < count; i++){
      mintNFTFor(to, _gender, _hair, _eyeWear, _face, _outfit, _images[i%_images.length], "");
    }
  } 
}