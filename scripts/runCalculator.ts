import { ethers } from "hardhat";
import fs from "fs";
import { SuperCalculator as ISuperCalculator } from "../types/ethers-contracts/SuperCalculator"

async function main() {
    const accounts = fs.readFileSync("local/accounts.json", "utf8");
    const { addressSuperCalculator } = JSON.parse(accounts);
    const SuperCalculator = await ethers.getContractFactory('SuperCalculator');
    const superCalculator = SuperCalculator.attach(addressSuperCalculator) as ISuperCalculator;
    const sum = await superCalculator.sumTwoNumbers(10, 23);
    console.log("Amount: ", sum)
    console.log("completado")
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
