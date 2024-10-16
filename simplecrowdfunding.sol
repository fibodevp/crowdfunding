// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleCrowdfunding {
    // Campaign information
    address public owner;
    uint256 public goal;
    uint256 public deadline;
    uint256 public totalContributed;
    bool public goalReached;
    
    // Mapping to track contributions
    mapping(address => uint256) public contributions;

    // Events
    event ContributionReceived(address contributor, uint256 amount);
    event GoalReached(uint256 totalAmount);
    event FundsWithdrawn(address owner, uint256 amount);
    event RefundIssued(address contributor, uint256 amount);

    // Constructor
    constructor(uint256 _goal, uint256 _duration) {
        owner = msg.sender;
        goal = _goal;
        deadline = block.timestamp + _duration;
        goalReached = false;
    }

    // Contribution function
    function contribute() public payable {
        require(block.timestamp < deadline, "Campaign has ended");
        require(msg.value > 0, "Contribution must be greater than zero");

        contributions[msg.sender] += msg.value;
        totalContributed += msg.value;

        emit ContributionReceived(msg.sender, msg.value);

        if (totalContributed >= goal && !goalReached) {
            goalReached = true;
            emit GoalReached(totalContributed);
        }
    }

    // Withdraw funds if goal is reached
    function withdrawFunds() public {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(goalReached, "Goal not reached yet");
        require(address(this).balance > 0, "No funds to withdraw");

        uint256 amount = address(this).balance;
        payable(owner).transfer(amount);

        emit FundsWithdrawn(owner, amount);
    }

    // Request a refund if the goal is not reached
    function requestRefund() public {
        require(block.timestamp >= deadline, "Campaign is still active");
        require(!goalReached, "Goal has been reached, no refunds");
        require(contributions[msg.sender] > 0, "No contributions to refund");

        uint256 contributedAmount = contributions[msg.sender];
        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(contributedAmount);

        emit RefundIssued(msg.sender, contributedAmount);
    }

    // Get contract balance
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
