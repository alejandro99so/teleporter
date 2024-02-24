// (c) 2023, Ava Labs, Inc. All rights reserved.
// See the file LICENSE for licensing terms.

// SPDX-License-Identifier: Ecosystem

pragma solidity 0.8.18;

import "../../external_contracts/Teleporter/TeleporterRegistry.sol";
import "../../external_contracts/Teleporter/ITeleporterMessenger.sol";

contract SenderDC {

    // The Teleporter registry contract manages different Teleporter contract versions.
    TeleporterRegistry public immutable teleporterRegistry;
  	
  	constructor(address teleporterRegistryAddress) {
        require(
            teleporterRegistryAddress != address(0),
            "SenderOnCChain: zero teleporter registry address"
        );

        teleporterRegistry = TeleporterRegistry(teleporterRegistryAddress);
    }
  
    function sendMessage(
        address destinationAddress,
        string calldata message
    ) external {
      	ITeleporterMessenger teleporterMessenger = teleporterRegistry.getLatestTeleporter();
      
        teleporterMessenger.sendCrossChainMessage(
            TeleporterMessageInput({
                destinationBlockchainID: 0x7fc93d85c6d62c5b2ac0b519c87010ea5294012d1e407030d6acd0021cac10d5,
                destinationAddress: destinationAddress,
                feeInfo: TeleporterFeeInfo({
                    feeTokenAddress: address(0),
                    amount: 0
                }),
                requiredGasLimit: 100000,
                allowedRelayerAddresses: new address[](0),
                message: abi.encode(message)
            })
        );
    }
}