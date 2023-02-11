// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoTax is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor() ERC20("Fake USD", "FUSD") {
        _mint(msg.sender, 1000 * 10**decimals());
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(uint256 amount) public {
        require(hasRole(MINTER_ROLE, msg.sender) || hasRole(HEAD_ROLE, msg.sender ), "Caller is not a minter or head");
        _mint(msg.sender, amount);
    }
}
