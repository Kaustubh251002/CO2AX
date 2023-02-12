// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";
import "./CoTax.sol";

// import "@openzeppelin/contracts/token/CoTax/CoTax.sol";

contract Gov_side is AccessControl {
    bytes32[] private all_industry = [
        FOOD_ROLE,
        TECHNOLOGY_ROLE,
        MANUFACTURING_ROLE,
        AGRICULTURE_ROLE
    ];
    uint256 public MIN_CORTEX_AMT = 5000000000000000000;
    address public owner;
    // bytes32[] Indus_types;
    struct Emition_Limits {
        uint256 MIN_EMITION;
        uint256 MAX_EMITION;
    }

    struct comp_data {
        address owner;
        string comp_name;
        address comp_contract_address;
        uint256 time_stamp;
        bytes32 comp_type;
        uint256 total_emision;
    }

    CoTax private CoTax_tkn;

    constructor(CoTax _CoTax_tkn) {
        owner = msg.sender;
        CoTax_tkn = _CoTax_tkn;
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(HEAD_ROLE, msg.sender);
        _grantRole(PAY_ROLE, address(this));
    }

    /**
    carbon_caps is used to store diffrent carbon caps for each industry
    */
    mapping(bytes32 => Emition_Limits) public carbon_caps;
    mapping(address => bytes32) internal rolesOfComp;
    mapping(address => mapping(uint256 => uint256)) public past_record_emition;

    function set_caps(
        bytes32 catagory,
        uint256 _MAX_EMITION,
        uint256 _MIN_EMITION
    ) public onlyRole(HEAD_ROLE) {
        // carbon_caps[Indus_types[0]]
        Emition_Limits storage bro = carbon_caps[catagory];
        bro.MIN_EMITION = _MIN_EMITION;
        bro.MAX_EMITION = _MAX_EMITION;
    }

    function whitelist_comp(address _comp_add) public {
        uint256 tkn_amount = CoTax(CoTax_tkn).balanceOf(_comp_add);
        if (tkn_amount >= MIN_CORTEX_AMT) {
            _grantRole(INDUSTRY_ROLE, _comp_add);
        } else {
            revert("CoTax token balance less than threshold");
        }
    }

    function change_minCortex(uint256 amt) external onlyRole(HEAD_ROLE) {
        MIN_CORTEX_AMT = amt;
    }

    function return_Cortex_amt(address _to) public view returns (uint256) {
        uint256 tkn_amount = CoTax(CoTax_tkn).balanceOf(_to);
        return tkn_amount;
    }

    function transfer_cortex(address _to, uint256 amount)
        public
        onlyRole(INDUSTRY_ROLE)
        returns (bool)
    {
        return CoTax(CoTax_tkn).transfer(_to, amount);
    }

    function tax_calculate(address comp_add, uint256 gas_emition)
        public
        returns (bool)
    {
        past_record_emition[comp_add][block.timestamp] = gas_emition;
        return tax(comp_add, gas_emition);
    }

    function transfer_to_CS() public onlyRole(HEAD_ROLE) {
        CoTax(CoTax_tkn).transfer(address(CoTax_tkn), 1000000000000000000000);
    }

    /**
    ---------------------------------
                INTERNAL
    ---------------------------------
    */

    function tax(address comp_add, uint256 gas_emition)
        internal
        returns (bool)
    {
        bytes32 role = rolesOfComp[comp_add];
        require(hasRole(role, comp_add));
        if (gas_emition <= carbon_caps[rolesOfComp[comp_add]].MIN_EMITION) {
            uint256 cal_reward = carbon_caps[rolesOfComp[comp_add]]
                .MIN_EMITION - gas_emition;
            _give_reward(comp_add, cal_reward);
            return true;
        } else if (
            gas_emition <= carbon_caps[rolesOfComp[comp_add]].MAX_EMITION
        ) {} else {
            // uint256 extra = gas_emition -
            //     carbon_caps[rolesOfComp[comp_add]].MAX_EMITION;
            // return extra*2
        }
    }

    function _cut_tax(address comp_add, uint256 _amount) internal {
        CoTax(CoTax_tkn).Transfer_to_gov(comp_add, owner, _amount);
    }

    function _give_reward(address comp_add, uint256 gas_emition_diff) internal {
        uint256 cal_reward = gas_emition_diff * 100000000000000000;
        CoTax(CoTax_tkn).transfer(comp_add, cal_reward);
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
// CoTax(tokenAddress).balanceOf(address(this))
/**
    struct comp_data {
        string comp_name;
        address comp_contract_address;
        uint256 past_year_emition;
        bytes32 comp_type;
    }
     */
// to transfer the tokens to another comp- use onlyasccess
