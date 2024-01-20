import { ethers } from "hardhat";
import fs from "fs";
import { UltraCalculator as IUltraCalculator } from "../types/ethers-contracts/UltraCalculator"

async function main() {
    const accounts = fs.readFileSync("local/accounts.json", "utf8");
    const { addressUltraCalculator } = JSON.parse(accounts);
    const UltraCalculator = await ethers.getContractFactory('UltraCalculator');
    const ultraCalculator = UltraCalculator.attach(addressUltraCalculator) as IUltraCalculator;
    const sum = await ultraCalculator.result();
    console.log("Amount: ", Number(sum))
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
