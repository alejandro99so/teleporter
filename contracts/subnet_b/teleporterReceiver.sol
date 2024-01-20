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
    IUltraCalculator public ultraCalculator;

    constructor(address _teleporterSenderAddress) {
        teleporterSenderAddress = _teleporterSenderAddress;
        owner = msg.sender;
    }

    error Unauthorized();

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

        (uint256 num1, uint256 num2) = abi.decode(message, (uint256, uint256));
        ultraCalculator.sumTwoNumbers(num1, num2);
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
