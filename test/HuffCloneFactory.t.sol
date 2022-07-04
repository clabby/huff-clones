// SPDX-License-Identifier: BSD
pragma solidity ^0.8.15;

import {Test} from "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {IExampleClone, IExampleCloneFactory} from "./Interfaces.sol";

contract HuffCloneFactoryTest is Test {
    IExampleCloneFactory internal factory;

    function setUp() public {
        IExampleClone impl = IExampleClone(HuffDeployer.deploy("ExampleClone"));
        factory = IExampleCloneFactory(
            HuffDeployer.deploy_with_args("ExampleCloneFactory", abi.encode(address(impl)))
        );
        emit log_named_address("Impl", address(impl));
        emit log_named_bytes("Impl Code", bytecodeAt(address(impl)));
        emit log_named_address("Factory", address(factory));
        emit log_named_bytes("Factory Code", bytecodeAt(address(factory)));
        emit log_named_bytes32("Impl Slot Factory", vm.load(address(factory), bytes32(0x0)));
    }

    // https://ethereum.stackexchange.com/questions/66554/is-it-possible-to-get-the-bytecode-of-an-already-deployed-contract-in-solidity
    function bytecodeAt(address _addr) public view returns (bytes memory code) {
        assembly {
            // retrieve the size of the code, this needs assembly
            let size := extcodesize(_addr)
            // allocate output byte array - this could also be done without assembly
            // by using code = new bytes(size)
            code := mload(0x40)
            // new "memory end" including padding
            mstore(0x40, add(code, and(add(add(size, 0x20), 0x1f), not(0x1f))))
            // store length in memory
            mstore(code, size)
            // actually retrieve the code, this needs assembly
            extcodecopy(_addr, add(code, 0x20), 0, size)
        }
    }

    /// -----------------------------------------------------------------------
    /// Gas benchmarking
    /// -----------------------------------------------------------------------

    function testGas_clone(
        address param1,
        uint256 param2,
        uint64 param3,
        uint8 param4
    ) public {
        factory.createClone(param1, param2, param3, param4);
    }

    /// -----------------------------------------------------------------------
    /// Correctness tests
    /// -----------------------------------------------------------------------

    function testCorrectness_clone(
        address param1,
        uint256 param2,
        uint64 param3,
        uint8 param4
    ) public {
        IExampleClone clone = IExampleClone(factory.createClone(
            param1,
            param2,
            param3,
            param4
        ));
        assertEq(clone.param1(), param1);
        assertEq(clone.param2(), param2);
        assertEq(clone.param3(), param3);
        assertEq(clone.param4(), param4);
    }
}