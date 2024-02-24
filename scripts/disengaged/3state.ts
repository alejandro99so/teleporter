import { ethers } from "hardhat";
import fs from "fs";
import { ReceiverDisengaged as IReceiverDisengaged } from "../../types/ethers-contracts/ReceiverDisengaged"

async function main() {
    const accounts = fs.readFileSync("local/accounts.json", "utf8");
    const { addressReceiver } = JSON.parse(accounts);
    const Receiver = await ethers.getContractFactory('ReceiverDisengaged');
    const receiver = Receiver.attach(addressReceiver) as IReceiverDisengaged;
    let message = await receiver.lastMessage();
    console.log("message: ", message);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
