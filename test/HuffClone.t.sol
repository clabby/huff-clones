// SPDX-License-Identifier: BSD
pragma solidity ^0.8.15;

import {Test} from "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {IExampleClone, IExampleCloneFactory} from "./Interfaces.sol";

contract ExampleCloneTest is Test {
    IExampleClone internal clone;
    IExampleCloneFactory internal factory;

    function setUp() public {
        IExampleClone impl = IExampleClone(HuffDeployer.deploy("ExampleClone"));
        factory = IExampleCloneFactory(HuffDeployer.deploy_with_args("ExampleCloneFactory", abi.encode(address(impl))));
        clone = IExampleClone(factory.createClone(address(this), type(uint256).max, 8008, 69));
    }

    /// -----------------------------------------------------------------------
    /// Gas benchmarking
    /// -----------------------------------------------------------------------

    function testGas_param1() public view {
        clone.param1();
    }

    function testGas_param2() public view {
        clone.param2();
    }

    function testGas_param3() public view {
        clone.param3();
    }

    function testGas_param4() public view {
        clone.param4();
    }
}