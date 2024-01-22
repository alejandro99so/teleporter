import { ethers } from "hardhat";
import fs from "fs";
import { SuperCalculator as ISuperCalculator } from "../types/ethers-contracts/SuperCalculator";

async function main() {
  const accounts = fs.readFileSync("local/accounts.json", "utf8");
  const { addressSuperCalculator } = JSON.parse(accounts);
  const SuperCalculator = await ethers.getContractFactory("SuperCalculator");
  const superCalculator = SuperCalculator.attach(
    addressSuperCalculator
  ) as ISuperCalculator;

  const sum = await superCalculator.sumTwoNumbers(15, 40);
  console.log("Amount: ", sum);
  // const subtract = await superCalculator.subtractTwoNumbers(40, 15);
  // console.log("Amount: ", subtract);
  // const multiply = await superCalculator.multiplyTwoNumbers(15, 40);
  // console.log("Amount: ", multiply);
  // const divide = await superCalculator.divideTwoNumbers(100, 10);
  // console.log("Amount: ", divide);

  console.log("completado");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
