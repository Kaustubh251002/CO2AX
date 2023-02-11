// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Gov_side is AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter private total_industries;

    bytes32[] private all_industry = [
        FOOD,
        TECHNOLOGY,
        MANUFACTURING,
        AGRICULTURE
    ];
    uint256 private MIN_CORTEX_AMT = 5000000000000000000;
    // bytes32[] Indus_types;
    struct Emition_Limits {
        uint256 MIN_EMITION;
        uint256 MID_EMITION;
        uint256 MAX_EMITION;
    }

    struct comp_data {
        string comp_name;
        address comp_contract_address;
        uint256 time_stamp;
        bytes32 comp_type;
        uint total_emision;
    }

    ERC20 private CoTax_tkn;

    constructor(ERC20 _CoTax_tkn) {
        CoTax_tkn = _CoTax_tkn;
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(HEAD_ROLE, msg.sender);
    }

    /**
    carbon_caps is used to store diffrent carbon caps for each industry
    */
    mapping(bytes32 => Emition_Limits) public carbon_caps;
    mapping(address => bytes32) internal rolesOfComp;

    function set_caps(
        bytes32 catagory,
        uint256 _MAX_EMITION,
        uint256 _MID_EMITION,
        uint256 _MIN_EMITION
    ) public onlyRole(HEAD_ROLE) {
        // carbon_caps[Indus_types[0]]
        Emition_Limits storage bro = carbon_caps[catagory];
        bro.MIN_EMITION = _MIN_EMITION;
        bro.MID_EMITION = _MID_EMITION;
        bro.MAX_EMITION = _MAX_EMITION;
    }

    function whitelist_comp(address _comp_add) public {
        uint256 tkn_amount = ERC20(CoTax_tkn).balanceOf(_comp_add);
        if (tkn_amount >= MIN_CORTEX_AMT) {
            _grantRole(INDUSTRY_ROLE, _comp_add);
        } else {
            revert("Kam pese hai re baba");
        }
    }

    function change_minCortex(uint256 amt) external onlyRole(HEAD_ROLE) {
        MIN_CORTEX_AMT = amt;
    }

    /**
    ---------------------------------
                INTERNAL
    ---------------------------------
    */

    function tax(address payable comp_add, uint256 gas_emition) internal {
        bytes32 role = rolesOfComp[comp_add];
        require(hasRole(role, comp_add));
        if (gas_emition <= carbon_caps[rolesOfComp[comp_add]].MIN_EMITION) {
            uint256 cal_reward = carbon_caps[rolesOfComp[comp_add]]
                .MIN_EMITION - gas_emition;
            _give_reward(comp_add, cal_reward);
            // give 0
        } else if (
            gas_emition <= carbon_caps[rolesOfComp[comp_add]].MID_EMITION
        ) {
            // give some
        } else if (
            gas_emition <= carbon_caps[rolesOfComp[comp_add]].MAX_EMITION
        ) {
            // give some
        } else {
            uint256 extra = gas_emition -
                carbon_caps[rolesOfComp[comp_add]].MAX_EMITION;
            // return extra*2
        }
    }

    function _give_reward(address payable comp_add, uint256 gas_emition_diff)
        internal
    {
        uint256 cal_reward = gas_emition_diff * 100000000000000000;
        IERC20(CoTax_tkn).transfer(comp_add, cal_reward);
    }

    function verify_indus(bytes32 name) internal view returns (bool) {
        uint256 flag = 0;
        for (uint256 i = 0; i < all_industry.length; i++) {
            if (all_industry[i] == name) {
                flag = 1;
            }
        }
        require(flag == 1, "ROLE not found");
        return true;
    }

    function govAddress() internal view returns (address) {
        return address(this);
    }
}
// ERC20(tokenAddress).balanceOf(address(this))
/**
    struct comp_data {
        string comp_name;
        address comp_contract_address;
        uint256 past_year_emition;
        bytes32 comp_type;
    }
     */
// to transfer the tokens to another comp- use onlyasccess
