// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

contract EIP712 {
    string internal constant DOMAIN_NAME = "YoVerseProtocol";

    /**
     * Hash of the EIP712 Domain Separator Schema
     */
    bytes32 public constant DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
    bytes32 public DOMAIN_SEPARATOR;

    constructor () {
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(DOMAIN_NAME)))
        );
    }

    /**
     * Calculates EIP712 encoding for a hash struct in this EIP712 Domain.
     *
     * @param eip712hash The EIP712 hash struct.
     * @return EIP712 hash applied to this EIP712 Domain.
     */
    // function hashEIP712Message(bytes32 eip712hash) internal view returns (bytes32) {
    //     return keccak256(abi.encodePacked("\x19\x01", DOMAIN_SEPARATOR, eip712hash));
    // }
}