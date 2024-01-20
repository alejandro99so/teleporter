import { ethers } from "hardhat";
import fs from "fs";
import { TeleporterSender as ITeleporterSender } from "../types/ethers-contracts/TeleporterSender"
import { SuperCalculator as ISuperCalculator } from "../types/ethers-contracts/SuperCalculator"

async function main() {
  const accounts = fs.readFileSync("local/accounts.json", "utf8");
  const { addressTeleporterSender, addressTeleporterReceiver, addressSuperCalculator } = JSON.parse(accounts);
  const TeleporterSender = await ethers.getContractFactory('TeleporterSender');
  const teleporterSender = TeleporterSender.attach(addressTeleporterSender) as ITeleporterSender;
  await teleporterSender.updateTeleporterReceiverAddress(addressTeleporterReceiver);
  const SuperCalculator = await ethers.getContractFactory('SuperCalculator');
  const superCalculator = SuperCalculator.attach(addressSuperCalculator) as ISuperCalculator;
  await superCalculator.updateSender(addressTeleporterSender);
  console.log("Completado")
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
