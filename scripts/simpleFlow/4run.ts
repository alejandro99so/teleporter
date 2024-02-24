import { ethers } from "hardhat";
import fs from "fs";
import { Sender as ISender } from "../../types/ethers-contracts/Sender"

async function main() {
    const accounts = fs.readFileSync("local/accounts.json", "utf8");
    const { addressSender, addressReceiver } = JSON.parse(accounts);
    const Sender = await ethers.getContractFactory('Sender');
    const sender = Sender.attach(addressSender) as ISender;
    await sender.sendMessage(addressReceiver, "hola");
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
