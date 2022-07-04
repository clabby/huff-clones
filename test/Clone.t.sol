// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract CloneTest is Test {
    /// @dev Address of the Clone contract.  
    IClone public clone;

    /// @dev Setup the testing environment.
    function setUp() public {
        // clone = IClone(HuffDeployer.deploy("ExampleClone"));
    }
}

interface IClone {
    // TODO
}
