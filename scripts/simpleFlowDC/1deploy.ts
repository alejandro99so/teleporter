import { ethers } from "hardhat";
import fs from "fs";

async function main() {
    const teleporterRegistryAddress = process.env.teleporterRegistryAddress
    const sender = await ethers.deployContract("Sender", [teleporterRegistryAddress]);
    await sender.waitForDeployment();
    const addressSender = await sender.getAddress();
    console.log({ addressSender })
    fs.writeFileSync(
        "local/accounts.json",
        JSON.stringify({
            addressSender
        })
    );
    console.log("Completado")
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
