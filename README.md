# Simple Crowdfunding Smart Contract

## Overview

This is a simple crowdfunding smart contract written in Solidity. It allows users to contribute funds to a campaign, and the campaign owner can withdraw the funds if the funding goal is reached by the deadline. If the goal is not met, contributors can request a refund of their contributions.

## Features

- **Contribution**: Anyone can contribute to the campaign by sending Ether to the contract.
- **Goal Tracking**: If the funding goal is met, the owner can withdraw the funds. If not, contributors can request refunds after the deadline.
- **Deadline**: The campaign has a set duration, after which no more contributions are accepted.

## Contract Functions

- `contribute()`: Contribute Ether to the campaign.
- `withdrawFunds()`: Owner can withdraw funds if the goal is reached.
- `requestRefund()`: Contributors can request a refund if the goal is not met after the campaign ends.
- `getContractBalance()`: Returns the current balance of the contract.

## Usage

### Deployment

1. Deploy the contract with an initial goal (in wei) and duration (in seconds).

```solidity
SimpleCrowdfunding crowdfunding = new SimpleCrowdfunding(1000000000000000000, 604800);
