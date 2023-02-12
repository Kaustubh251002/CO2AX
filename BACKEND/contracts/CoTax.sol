// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoTax is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant HEAD_ROLE = keccak256("HEAD_ROLE");

    bytes32 public constant INDUSTRY_ROLE = keccak256("INDUSTRY_ROLE");
    bytes32 public constant PAY_ROLE = keccak256("PAY_ROLE");

    bytes32 public constant FOOD_ROLE = keccak256("FOOD_ROLE");
    bytes32 public constant TECHNOLOGY_ROLE = keccak256("TECHNOLOGY_ROLE");
    bytes32 public constant MANUFACTURING_ROLE =
        keccak256("MANUFACTURING_ROLE");
    bytes32 public constant AGRICULTURE_ROLE = keccak256("AGRICULTURE_ROLE");

    constructor() ERC20("CoTax", "FOOL") {
        _mint(msg.sender, 2000 * 10**decimals());
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(HEAD_ROLE, msg.sender);
    }

    function Transfer_to_gov(
        address _owner,
        address _to,
        uint256 _amt
    ) public onlyRole(PAY_ROLE) {
        _transfer(_owner, _to, _amt);
    }

    function mint(uint256 amount) public {
        require(
            hasRole(MINTER_ROLE, msg.sender) || hasRole(HEAD_ROLE, msg.sender),
            "Caller is not a minter or head"
        );
        _mint(msg.sender, amount);
    }
}
