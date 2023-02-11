// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Indus_s.sol";
import "./gov.sol";

contract Industry_factory is Gov_side {
    constructor(ERC20 tkn) Gov_side(tkn) {}

    uint256 private total_comp;
    mapping(uint256 => comp_data) private deployed_comp;
    event New_comp(
        uint256 id,
        string indexed name,
        bytes32 indexed typeOf,
        uint256 indexed time
    );

    function addGovernorAddress(
        string memory _comp_name,
        bytes32 _comp_type,
        uint256 _total_emision
    ) public returns (address) {
        require(verify_indus(_comp_type));
        uint256 comp_Id = total_comp++;
        comp_data storage new_comp = deployed_comp[comp_Id];
        new_comp.comp_name = _comp_name;
        new_comp.comp_type = _comp_type;
        new_comp.total_emision = _total_emision;
        new_comp.comp_contract_address = address(
            new Indus_side(
                _comp_name,
                _comp_type,
                govAddress(),
                new_comp.time_stamp,
                _total_emision
            )
        );
        new_comp.time_stamp = block.timestamp;
        emit New_comp(comp_Id, _comp_name, _comp_type, block.timestamp);
        return new_comp.comp_contract_address;
    }

    function get_all_comp() public view returns (comp_data[] memory data) {
        data = new comp_data[](total_comp);
        for (uint256 i = 0; i < total_comp; i++) {
            data[i] = deployed_comp[i];
        }
    }
}
