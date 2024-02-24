// (c) 2023, Ava Labs, Inc. All rights reserved.
// See the file LICENSE for licensing terms.

// SPDX-License-Identifier: Ecosystem

pragma solidity 0.8.18;

import "../../external_contracts/Teleporter/TeleporterRegistry.sol";
import "../../external_contracts/Teleporter/ITeleporterMessenger.sol";
import "../../external_contracts/Teleporter/ITeleporterReceiver.sol";

contract ReceiverDC is ITeleporterReceiver {

    // The Teleporter registry contract manages different Teleporter contract versions.
    TeleporterRegistry public immutable teleporterRegistry;
    bytes32 public myOriginChainID;
    address public myOriginSenderAddress;
  	
  	constructor(address teleporterRegistryAddress) {
        require(
            teleporterRegistryAddress != address(0),
            "SenderOnCChain: zero teleporter registry address"
        );

        teleporterRegistry = TeleporterRegistry(teleporterRegistryAddress);
    }
  
    string public lastMessage;

    function receiveTeleporterMessage(
        bytes32 originChainID,
        address originSenderAddress,
        bytes calldata message
    ) external {
        myOriginChainID = originChainID;
        myOriginSenderAddress = originSenderAddress;
        // Only the Teleporter receiver can deliver a message. Function throws an error if 
        // msg.sender is not registered
        teleporterRegistry.getVersionFromAddress(msg.sender);

        // Store the message.
        lastMessage = abi.decode(message, (string));
    }
}