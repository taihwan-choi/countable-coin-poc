// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Countable USD – ERC20 token with structured semantic transaction data
/// @notice This contract provides a proof-of-concept implementation of the
/// semantic transaction structure proposed in the "Countable Coin" research.
/// It extends standard ERC20 transfers by attaching structured accounting
/// metadata to token transfers so that enterprise systems can interpret
/// the business meaning of transactions.
contract CountableCoin is ERC20, Ownable {

    /// @notice Allowlist of valid department codes
    /// Used to validate semantic transaction metadata
    mapping(string => bool) public allowedDept;

    /// @notice Allowlist of valid business purpose codes
    /// Used to validate semantic transaction metadata
    mapping(string => bool) public allowedPurpose;

    /// @notice Extended transfer event containing structured semantic information
    /// @dev Enterprise systems such as ERP or auditing platforms can listen
    /// to this event to interpret the accounting meaning of a blockchain transaction
    event CountableTransfer(
        address indexed from,
        address indexed to,
        uint256 amount,
        string deptCode,
        string purposeCode,
        string refId,
        uint256 timestamp
    );

    /// @notice Initializes the token and assigns the initial supply to the deployer
    /// @dev OpenZeppelin v5 requires specifying the initial owner in the constructor
    constructor() ERC20("Countable USD", "cUSD") Ownable(msg.sender) {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }

    /// @notice Configure allowed department codes
    /// @param codes List of department codes
    /// @param isAllowed Whether the codes should be allowed or removed
    /// @dev Only the contract owner can update the allowlist
    function setAllowedDept(string[] calldata codes, bool isAllowed) external onlyOwner {
        for (uint256 i = 0; i < codes.length; i++) {
            allowedDept[codes[i]] = isAllowed;
        }
    }

    /// @notice Configure allowed business purpose codes
    /// @param codes List of purpose codes
    /// @param isAllowed Whether the codes should be allowed or removed
    /// @dev Only the contract owner can update the allowlist
    function setAllowedPurpose(string[] calldata codes, bool isAllowed) external onlyOwner {
        for (uint256 i = 0; i < codes.length; i++) {
            allowedPurpose[codes[i]] = isAllowed;
        }
    }

    /// @notice Transfer tokens together with structured semantic data
    /// @param to Recipient address
    /// @param amount Token amount
    /// @param deptCode Department code representing the organizational context
    /// @param purposeCode Business purpose code describing the transaction type
    /// @param refId Reference identifier such as an invoice ID or transaction reference
    /// @return success Returns true if the transfer succeeds
    ///
    /// @dev This function demonstrates how semantic metadata can be attached
    /// to token transfers so that enterprise systems can interpret the
    /// accounting meaning of blockchain transactions.
    function transferWithCountableData(
        address to,
        uint256 amount,
        string calldata deptCode,
        string calldata purposeCode,
        string calldata refId
    ) external returns (bool) {

        require(allowedDept[deptCode], "dept not allowed");
        require(allowedPurpose[purposeCode], "purpose not allowed");

        _transfer(msg.sender, to, amount);

        emit CountableTransfer(
            msg.sender,
            to,
            amount,
            deptCode,
            purposeCode,
            refId,
            block.timestamp
        );

        return true;
    }
}