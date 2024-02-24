// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "./2sender.sol";

contract Origin {
    ISenderDisengaged public senderDisengaged;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function sendMessage(
        string calldata message,
        address addressSenderDisengaged,
        address destinationAddress
    ) external {
        senderDisengaged = ISenderDisengaged(addressSenderDisengaged);
        senderDisengaged.sendMessage(destinationAddress, message);
    }
}
