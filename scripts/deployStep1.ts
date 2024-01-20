import { ethers } from "hardhat";
import fs from "fs";

async function main() {
  const superCalculator = await ethers.deployContract("SuperCalculator");
  await superCalculator.waitForDeployment();
  const addressSuperCalculator = await superCalculator.getAddress();
  const teleporterSender = await ethers.deployContract("TeleporterSender", [addressSuperCalculator]);
  await teleporterSender.waitForDeployment();
  const addressTeleporterSender = await teleporterSender.getAddress();
  fs.writeFileSync(
    "local/accounts.json",
    JSON.stringify({
      addressSuperCalculator,
      addressTeleporterSender
    })
  );
  console.log("Completado")
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
