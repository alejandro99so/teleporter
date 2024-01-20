import { ethers } from "hardhat";
import fs from "fs";

async function main() {
  const accounts = fs.readFileSync("local/accounts.json", "utf8");
  const { addressTeleporterSender } = JSON.parse(accounts);
  const teleporterReceiver = await ethers.deployContract("TeleporterReceiver", [addressTeleporterSender]);
  await teleporterReceiver.waitForDeployment();
  const addressTeleporterReceiver = await teleporterReceiver.getAddress();
  const ultraCalculator = await ethers.deployContract("UltraCalculator", [addressTeleporterReceiver]);
  await ultraCalculator.waitForDeployment();
  const addressUltraCalculator = await ultraCalculator.getAddress();
  fs.writeFileSync(
    "local/accounts.json",
    JSON.stringify({
      ...JSON.parse(accounts),
      addressTeleporterReceiver,
      addressUltraCalculator
    })
  );
  await teleporterReceiver.updateUltraCalculator(addressUltraCalculator);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
