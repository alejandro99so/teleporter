// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "../external_contracts/Teleporter/ITeleporterMessenger.sol";
import "../external_contracts/Teleporter/ITeleporterReceiver.sol";
import "./ultraCalculator.sol";

contract TeleporterReceiver is ITeleporterReceiver {
    uint256 public result;
    bytes32 public _originChainID;
    address public _originSenderAddress;
    ITeleporterMessenger public immutable teleporterMessenger =
        ITeleporterMessenger(0x50A46AA7b2eCBe2B1AbB7df865B9A87f5eed8635);
    address public owner;
    address public teleporterSenderAddress;

    enum OperationType {
        Sum,
        Subtract,
        Multiply,
        Divide
    }

    IUltraCalculator public ultraCalculator;

    constructor(address _teleporterSenderAddress) {
        teleporterSenderAddress = _teleporterSenderAddress;
        owner = msg.sender;
    }

    error Unauthorized();
    error OperationTypeNotFound(uint8 _type);

    function receiveTeleporterMessage(
        bytes32 originChainID,
        address originSenderAddress,
        bytes calldata message
    ) external {
        if (
            msg.sender != address(teleporterMessenger) ||
            teleporterSenderAddress != originSenderAddress
        ) {
            revert Unauthorized();
        }
        _originChainID = originChainID;
        _originSenderAddress = originSenderAddress;

        (OperationType operationType, uint256 num1, uint256 num2) = abi.decode(
            message,
            (OperationType, uint256, uint256)
        );
        if (operationType == OperationType.Sum) {
            ultraCalculator.sumTwoNumbers(num1, num2);
        } else if (operationType == OperationType.Subtract) {
            ultraCalculator.subtractTwoNumbers(num1, num2);
        } else if (operationType == OperationType.Multiply) {
            ultraCalculator.multiplyTwoNumbers(num1, num2);
        } else if (operationType == OperationType.Divide) {
            ultraCalculator.divideTwoNumbers(num1, num2);
        } else {
            revert OperationTypeNotFound(uint8(operationType));
        }
    }

    function updateTeleporterSenderAddress(
        address _teleporterSenderAddress
    ) external {
        require(msg.sender == owner, "Only owner");
        teleporterSenderAddress = _teleporterSenderAddress;
    }

    function updateUltraCalculator(address ultraCalculatorAddress) external {
        require(msg.sender == owner, "Only owner");
        ultraCalculator = IUltraCalculator(ultraCalculatorAddress);
    }
}
