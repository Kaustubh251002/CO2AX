// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./gov.sol";

contract Indus_side is AccessControl {
    string private comp_name;
    Gov_side private govaddress;
    bytes32 private immutable Industry_type;
    uint256 private deploy_time;
    uint256 private prev_emition;
    address public owner;

    constructor(
        address _owner_,
        string memory _comp_name,
        bytes32 _type,
        Gov_side _govCon,
        uint256 _deploy_time,
        uint256 _prev_emition
    ) {
        owner = _owner_;
        comp_name = _comp_name;
        Industry_type = _type;
        govaddress = _govCon;
        deploy_time = _deploy_time;
        prev_emition = _prev_emition;
    }

    function _owner()public view returns(address) {
        return owner;
    }

    function company_name() public view returns (string memory) {
        return comp_name;
    }

    function company_type() public view returns (bytes32) {
        return Industry_type;
    }

    function deployed_time() public view returns (uint256) {
        return deploy_time;
    }

    function previous_emition() public view returns (uint256) {
        return prev_emition;
    }

    function transfer_bw_comp(address _to, uint256 amount)
        public
        returns (bool)
    {
        require(hasRole(INDUSTRY_ROLE, _to), "Not industry");
        uint256 tkn_amount = Gov_side(govaddress).return_Cortex_amt(
            address(this)
        );
        uint256 threshold_val = Gov_side(govaddress).MIN_CORTEX_AMT();
        require(tkn_amount >= threshold_val, "cannot go below threshold");
        return Gov_side(govaddress).transfer_cortex(_to, amount);
    }

    function request_for_whitelist() external {
        Gov_side(govaddress).whitelist_comp(address(this));
    }

    function pay_tax(uint256 _amount_emited) public returns(bool){
        require(msg.sender == owner, "Not owner");
        return
            Gov_side(govaddress).tax_calculate(address(this), _amount_emited);
    }
}
