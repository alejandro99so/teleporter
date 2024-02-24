import { ethers } from "hardhat";
import fs from "fs";

async function main() {
    const teleporterRegistryAddress = process.env.teleporterRegistryAddress
    const origin = await ethers.deployContract("Origin");
    await origin.waitForDeployment();
    const addressOrigin = await origin.getAddress();
    const sender = await ethers.deployContract("SenderDisengaged", [teleporterRegistryAddress]);
    await sender.waitForDeployment();
    const addressSender = await sender.getAddress();
    console.log({ addressSender })
    fs.writeFileSync(
        "local/accounts.json",
        JSON.stringify({
            addressOrigin,
            addressSender
        })
    );
    console.log("Completado")
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
