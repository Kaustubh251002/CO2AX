// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Indus_side is AccessControl {
    bytes32 private immutable Industry_type;
    constructor(bytes32 hello){
        Industry_type=hello;
    }
}
