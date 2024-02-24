import { ethers } from "hardhat";
import fs from "fs";

async function main() {
    const accounts = fs.readFileSync("local/accounts.json", "utf8");
    const teleporterRegistryAddress = process.env.teleporterRegistryAddress
    const receiver = await ethers.deployContract("ReceiverDisengagedDC", [teleporterRegistryAddress]);
    await receiver.waitForDeployment();
    const addressReceiver = await receiver.getAddress();
    console.log({ addressReceiver })
    fs.writeFileSync(
        "local/accounts.json",
        JSON.stringify({
            ...JSON.parse(accounts),
            addressReceiver,
        })
    );
    console.log("Completado")
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
