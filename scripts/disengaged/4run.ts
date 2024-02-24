import { ethers } from "hardhat";
import fs from "fs";
import { Origin as IOrigin } from "../../types/ethers-contracts/Origin"

async function main() {
    const accounts = fs.readFileSync("local/accounts.json", "utf8");
    const { addressSender, addressReceiver, addressOrigin } = JSON.parse(accounts);
    const Origin = await ethers.getContractFactory('Origin');
    const origin = Origin.attach(addressOrigin) as IOrigin;
    await origin.sendMessage("hola", addressSender, addressReceiver);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
