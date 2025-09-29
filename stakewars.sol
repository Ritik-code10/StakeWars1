SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title StakeWars
 * @dev A simple staking contract where users can stake Ether and withdraw with rewards.
 */
contract StakeWars {
    mapping(address => uint256) public stakes;   // Track user stakes
    uint256 public totalStaked;                  // Total Ether staked
    uint256 public rewardRate = 10;              // Fixed reward rate (10%)

    /// @notice Allows users to stake Ether
    function stake() external payable {
        require(msg.value > 0, "You must stake some Ether");
        stakes[msg.sender] += msg.value;
        totalStaked += msg.value;
    }

    /// @notice Calculate reward for a user
    function calculateReward(address user) public view returns (uint256) {
        return (stakes[user] * rewardRate) / 100;
    }

    /// @notice Withdraw staked Ether along with rewards
    function withdraw() external {
        uint256 userStake = stakes[msg.sender];
        require(userStake > 0, "No stake to withdraw");

        uint256 reward = calculateReward(msg.sender);
        uint256 totalAmount = userStake + reward;

        stakes[msg.sender] = 0;  // Reset user stake
        payable(msg.sender).transfer(totalAmount);
    }
}
