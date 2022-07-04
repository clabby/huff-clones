// SPDX-License-Identifier: BSD
pragma solidity ^0.8.15;

interface IExampleClone {
    function param1() external pure returns (address);
    function param2() external pure returns (uint256);
    function param3() external pure returns (uint64);
    function param4() external pure returns (uint8);
}

interface IExampleCloneFactory {
    function createClone(
        address param1,
        uint256 param2,
        uint64 param3,
        uint8 param4
    ) external returns (address clone);
}