// SPDX-License-Identifier: Unlicense

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "./EIP712.sol";

pragma solidity ^0.8.0;

contract SignatureMinting is ERC20, AccessControl, EIP712 {

    using ECDSA for bytes32;

    struct MintRequest {
        address to;
        uint256 quantity;
        uint128 validityStartTimestamp;
        uint128 validityEndTimestamp;
        bytes32 uid;
    }

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /// @dev Mapping from mint request UID => whether the mint request is processed.
    mapping(bytes32 => bool) private minted;

    bytes32 private constant TYPEHASH =
        keccak256(
            "MintRequest(address to,uint256 quantity,uint128 validityStartTimestamp,uint128 validityEndTimestamp,bytes32 uid)"
        );

    constructor (string memory name, string memory symbol) ERC20(name, symbol){
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mintWithSignature(MintRequest calldata _req, bytes calldata _signature) external {
        verifyRequest(_req, _signature);
        _mint(_req.to, _req.quantity);
    }

    /// @dev Verifies that a mint request is valid.
    function verifyRequest(MintRequest calldata _req, bytes calldata _signature) internal returns (address) {
        (bool success, address signer) = verify(_req, _signature);
        require(success, "invalid signature");
        require(_req.quantity > 0, "zero quantity");

        minted[_req.uid] = true;

        return signer;
    }

    /// @dev Verifies that a mint request is signed by an account holding MINTER_ROLE (at the time of the function call).
    function verify(MintRequest calldata _req, bytes calldata _signature) public view returns (bool, address) {
        address signer = recoverAddress(_req, _signature);
        return (!minted[_req.uid] && hasRole(MINTER_ROLE, signer), signer);
    }

    /// @dev Returns the address of the signer of the mint request.
    function recoverAddress(MintRequest calldata _req, bytes calldata _signature) internal view returns (address) {
        return DOMAIN_SEPARATOR.toTypedDataHash(keccak256(_encodeRequest(_req))).recover(_signature);
    }

    /// @dev Resolves 'stack too deep' error in `recoverAddress`.
    function _encodeRequest(MintRequest calldata _req) internal pure returns (bytes memory) {
        return
            abi.encode(
                TYPEHASH,
                _req.to,
                _req.quantity,
                _req.validityStartTimestamp,
                _req.validityEndTimestamp,
                _req.uid
            );
    }
}