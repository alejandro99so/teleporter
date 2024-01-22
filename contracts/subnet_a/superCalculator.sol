// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "./teleporterSender.sol";

contract SuperCalculator {
    ITeleporterSender public teleporterSender;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function updateSender(address _teleporterSender) external {
        require(msg.sender == owner, "Only owner");
        teleporterSender = ITeleporterSender(_teleporterSender);
    }

    function sumTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 result) {
        teleporterSender.sendMessage(OperationType.Sum, num1, num2);
        return num1 + num2;
    }

    function subtractTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 result) {
        teleporterSender.sendMessage(OperationType.Subtract, num1, num2);
        return num1 - num2;
    }

    function multiplyTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 result) {
        teleporterSender.sendMessage(OperationType.Multiply, num1, num2);
        return num1 * num2;
    }

    function divideTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 result) {
        require(num2 != 0, "Cannot divide by zero");
        teleporterSender.sendMessage(OperationType.Divide, num1, num2);
        return num1 / num2;
    }
}
