// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./gov.sol";

contract Indus_side is AccessControl {
    string private comp_name;
    address private govaddress;
    bytes32 private immutable Industry_type;
    uint256 private deploy_time;
    uint256 private prev_emition;

    constructor(
        string memory _comp_name,
        bytes32 _type,
        address _govCon,
        uint256 _deploy_time,
        uint256 _prev_emition
    ) {
        comp_name = _comp_name;
        Industry_type = _type;
        govaddress = _govCon;
        deploy_time = _deploy_time;
        prev_emition = _prev_emition;
    }

    function company_name() public view returns (string memory) {
        return comp_name;
    }

    function company_type() public view returns (bytes32) {
        return Industry_type;
    }

    function request_for_whitelist() external {
        Gov_side(govaddress).whitelist_comp(address(this));
    }
}
