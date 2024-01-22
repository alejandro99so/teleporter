// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
import "../external_contracts/Teleporter/ITeleporterMessenger.sol";

enum OperationType {
    Sum,
    Subtract,
    Multiply,
    Divide
}

contract TeleporterSender {
    ITeleporterMessenger public immutable teleporterMessenger =
        ITeleporterMessenger(0x50A46AA7b2eCBe2B1AbB7df865B9A87f5eed8635);

    address public teleporterReceiverAddress;
    address public owner;
    address public superCalculatorAddress;

    constructor(address _superCalculatorAddress) {
        superCalculatorAddress = _superCalculatorAddress;
        owner = msg.sender;
    }

    function sendMessage(
        OperationType operationType,
        uint256 num1,
        uint256 num2
    ) external returns (uint256 messageID) {
        require(
            msg.sender == owner || msg.sender == superCalculatorAddress,
            "Only owner or super calculator"
        );
        bytes memory message = abi.encode(operationType, num1, num2);
        return
            uint(
                teleporterMessenger.sendCrossChainMessage(
                    TeleporterMessageInput({
                        destinationBlockchainID: 0xd7cdc6f08b167595d1577e24838113a88b1005b471a6c430d79c48b4c89cfc53,
                        destinationAddress: teleporterReceiverAddress,
                        feeInfo: TeleporterFeeInfo({
                            feeTokenAddress: address(0),
                            amount: 0
                        }),
                        requiredGasLimit: 100000,
                        allowedRelayerAddresses: new address[](0),
                        message: message
                    })
                )
            );
    }

    function updateTeleporterReceiverAddress(
        address _teleporterReceiverAddress
    ) external {
        require(msg.sender == owner, "Only owner");
        teleporterReceiverAddress = _teleporterReceiverAddress;
    }

    function updateSuperCalculatorAddress(
        address _superCalculatorAddress
    ) external {
        require(msg.sender == owner, "Only owner");
        superCalculatorAddress = _superCalculatorAddress;
    }
}

interface ITeleporterSender {
    function sendMessage(
        OperationType operationType,
        uint256 num1,
        uint256 num2
    ) external returns (uint256 messageID);
}
