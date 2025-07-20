// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {ManualToken} from "src/ManualToken.sol";

contract ManualTokenTest is Test {
    ManualToken manualToken;
    address public alice = makeAddr("alice");
    address public bob = makeAddr("bob");

    uint256 public constant TOTAL_SUPPLY = 100 ether;
    uint256 public constant DECIMAL = 18;

    function setUp() public {
        manualToken = new ManualToken();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Manual Token";
        string memory name = manualToken.name();
        assertEq(expectedName, name);
    }

    function testTotalSupplyIsAccurate() public view {
        uint256 expectedTotalSupply = TOTAL_SUPPLY;
        uint256 totalSupply = manualToken.totalSupply();
        assertEq(expectedTotalSupply, totalSupply);
    }

    function testDecimalIsAccurate() public view {
        uint256 expectedDecimal = DECIMAL;
        uint256 decimal = manualToken.decimals();
        assertEq(expectedDecimal, decimal);
    }

    function testBalanceOfZeroAddress() public view {
        uint256 balance = manualToken.balanceOf(address(0));
        assertEq(balance, 0);
    }

    /*function testTransferSuccess() public {
        uint256 transferAmount = 10e18;

        bytes32 slot = keccak256(abi.encode(alice, uint256(0)));
        vm.store(address(manualToken), slot, bytes32(uint256(50e18)));
        uint256 aliceInitial = manualToken.balanceOf(alice);
        uint256 bobInitial = manualToken.balanceOf(bob);

        manualToken.transfer(bob, transferAmount);

        assertEq(manualToken.balanceOf(alice), aliceInitial - transferAmount);
        assertEq(manualToken.balanceOf(bob), bobInitial + transferAmount);
    }
    */

}
