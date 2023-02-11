// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Gov_side is AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter private total_industries;

    bytes32 private FOOD = keccak256("FOOD");
    // bytes32[] Indus_types;
    struct Emition_Limits {
        uint256 MIN_EMITION;
        uint256 MID_EMITION;
        uint256 MAX_EMITION;
    }

    struct comp_data {
        string comp_name;
        address comp_contract_address;
        uint256 past_year_emition;
        bytes32 comp_type;
    }

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(HEAD_ROLE, msg.sender);
    }

    /**
    carbon_caps is used to store diffrent carbon caps for each industry
    */
    mapping(bytes32 => Emition_Limits) public carbon_caps;
    mapping(address => comp_data) public all_comp;

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

    // function add_indus(bytes32 catagory) public onlyRole(HEAD_ROLE) {
    //     Indus_types.push(catagory);
    // }

    function add_comp(
        string memory _comp_name,
        address _comp_contract_address,
        uint256 _past_year_emition,
        bytes32 _comp_type
    ) public onlyRole(HEAD_ROLE) {
        comp_data storage bro=all_comp[_comp_contract_address];
        bro.comp_name=_comp_name;
        bro.comp_contract_address=_comp_contract_address;
        bro.past_year_emition=_past_year_emition;
        bro.comp_type=_comp_type;
    }

    // function give_tax(bytes32 ind,uint256 total_emition)internal view returns(uint256){
    //     require(total_emition>0,"total emition cannot be 0");
    //     if(total_emition<=MIN_EMITION){
    //     // reward
    //     return 0;
    //     }else if(total_emition<=MID_EMITION){

    //     }else if(total_emition<=MAX_EMITION){

    //     }else{

    //     }
    // }
}
// ERC20(tokenAddress).balanceOf(address(this))
