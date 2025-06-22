// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "script/DeployOurToken.s.sol";
import {OurToken} from "src/OurToken.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("BOB");
    address alice = makeAddr("ALICE");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobbalance() public view {
        // Arrange
        uint256 bobBalance = ourToken.balanceOf(bob);
        // Act / Assert
        assertEq(bobBalance, STARTING_BALANCE);
        // can also be written this way:
        // assertEq(STARTING_BALANCE, ourToken.balanceOf(bob));
    }

    function testAllowancesWorks() public {
        // Arrange
        uint256 initialAllowance = 1000;

        // Act / Assert
        // Bob approves Alice to spend tokens on her behalf
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        uint256 transferAmount = 500;
        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testTransferAllTokens() public {
        // Arrange
        uint256 bobBalance = ourToken.balanceOf(bob);

        // Act / Assert
        vm.prank(bob);
        ourToken.transfer(alice, bobBalance);

        assertEq(ourToken.balanceOf(bob), 0);
        assertEq(ourToken.balanceOf(alice), bobBalance);
    }

    function testRevertWhenAllowanceNotApproved() public {
        // Arrange / Act /Assert
        uint256 transferAmount = 500;

        vm.prank(alice);
        vm.expectRevert();
        ourToken.transferFrom(bob, alice, transferAmount);
    }

    function testAllowanceApprovedTwice() public {
        // Arrange
        uint256 initialAllowance = 800;
        uint256 transferAmount1 = 200;
        uint256 transferAmount2 = 600;

        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount1);
        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount2);

        // Assert
        assertEq(initialAllowance, transferAmount1 + transferAmount2);
    }

    function testZeroTokenTransferSuccessful() public {
        // Arrange
        uint256 zeroTransferAmount = 0;

        // Act / Assert
        vm.prank(bob);
        ourToken.transfer(alice, zeroTransferAmount);

        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE);
        assertEq(ourToken.balanceOf(alice), 0);
    }

    function testSelfTransfer() public {
        // Arrange / Act / Assert
        uint256 transferAmount = 0;

        vm.prank(bob);
        ourToken.transfer(bob, transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testAllowanceDoesNotAffectBalance() public {
        // Arrange / Act / Assert
        uint256 allowance;
        vm.prank(bob);
        ourToken.approve(alice, allowance);

        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE);
    }
}
