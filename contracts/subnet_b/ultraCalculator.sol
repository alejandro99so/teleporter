// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract UltraCalculator {
    address public owner;
    address public teleporterReceiverAddress;
    uint256 public result;

    constructor(address _teleporterReceiverAddress) {
        teleporterReceiverAddress = _teleporterReceiverAddress;
        owner = msg.sender;
    }

    function updateTeleporterReceiverAddress(
        address _teleporterReceiverAddress
    ) external {
        require(msg.sender == owner, "Only owner");
        teleporterReceiverAddress = _teleporterReceiverAddress;
    }

    function sumTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 _result) {
        require(
            msg.sender == owner || msg.sender == teleporterReceiverAddress,
            "Only owner or teleporter receiver address"
        );
        result = num1 + num2;
        return result;
    }

    function subtractTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 _result) {
        require(
            msg.sender == owner || msg.sender == teleporterReceiverAddress,
            "Only owner or teleporter receiver address"
        );
        result = num1 - num2;
        return result;
    }

    function multiplyTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 _result) {
        require(
            msg.sender == owner || msg.sender == teleporterReceiverAddress,
            "Only owner or teleporter receiver address"
        );
        result = num1 * num2;
        return result;
    }

    function divideTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 _result) {
        require(
            msg.sender == owner || msg.sender == teleporterReceiverAddress,
            "Only owner or teleporter receiver address"
        );
        require(num2 != 0, "Cannot divide by zero");
        result = num1 / num2;
        return result;
    }
}

interface IUltraCalculator {
    function sumTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 _result);

    function subtractTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 _result);

    function multiplyTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 _result);

    function divideTwoNumbers(
        uint256 num1,
        uint256 num2
    ) external returns (uint256 _result);
}
