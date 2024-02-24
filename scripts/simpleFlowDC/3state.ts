import { ethers } from "hardhat";
import fs from "fs";
import { Receiver as IReceiver } from "../../types/ethers-contracts/Receiver"

async function main() {
    const accounts = fs.readFileSync("local/accounts.json", "utf8");
    const { addressReceiver } = JSON.parse(accounts);
    const Receiver = await ethers.getContractFactory('Receiver');
    const receiver = Receiver.attach(addressReceiver) as IReceiver;
    let message = await receiver.lastMessage();
    console.log("message: ", message);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
