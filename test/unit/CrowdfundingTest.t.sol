// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {Crowdfunding} from "src/Crowdfunding.sol";

contract CrowdfundingTest is Test {
    Crowdfunding public crowdfunding;
    address public owner;
    address public user1 = address(0x1);
    address public user2 = address(0x2);

    function setUp() external {
        crowdfunding = new Crowdfunding();
        owner = address(this);
    }

    function test_setUp() public {
        console.log("Crowdfunding Contract deployed at:", address(crowdfunding));
        assert(address(crowdfunding) != address(0));
    }

    function test_Fund() public {
        vm.deal(user1, 5 ether); // Cấp 5 ETH cho user1
        vm.startPrank(user1);
        crowdfunding.fund{value: 1 ether}();
        vm.stopPrank();

        assertEq(crowdfunding.getBalance(), 1 ether);
        assertEq(crowdfunding.AmountOfFunder(user1), 1 ether);
    }

    function test_Withdraw() public {
        vm.deal(owner, 5 ether);
        vm.prank(owner);
        crowdfunding.fund{value: 2 ether}();

        uint256 balanceBefore = address(owner).balance;

        vm.prank(owner);
        crowdfunding.withdraw();

        assertEq(crowdfunding.getBalance(), 0);
        assert(address(owner).balance > balanceBefore);
    }

    function test_WithdrawByNonOwner() public {
        vm.deal(user1, 5 ether);
        vm.prank(user1);
        crowdfunding.fund{value: 2 ether}();

        vm.expectRevert(); // Non-owner không thể rút tiền
        vm.prank(user1);
        crowdfunding.withdraw();
    }
}
