import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require('dotenv').config();

const mnemonic = process.env.MNEMONIC
const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    aChain: {
      url: "https://subnets.avax.network/amplify/testnet/rpc",
      chainId: 78430,
      gasPrice: 20000000000,
      accounts: { mnemonic: mnemonic }
    },
    bChain: {
      url: "https://subnets.avax.network/bulletin/testnet/rpc",
      chainId: 78431,
      gasPrice: 20000000000,
      accounts: { mnemonic: mnemonic }
    }
  }
};

export default config;
