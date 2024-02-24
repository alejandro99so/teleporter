import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require('dotenv').config();

const mnemonic = process.env.MNEMONIC
const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    dispatch: {
      url: "https://subnets.avax.network/dispatch/testnet/rpc",
      chainId: 779672,
      gasPrice: 25000000000,
      accounts: { mnemonic: mnemonic }
    },
    echo: {
      url: "https://subnets.avax.network/echo/testnet/rpc",
      chainId: 173750,
      gasPrice: 25000000000,
      accounts: { mnemonic: mnemonic }
    },
    cChain: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",
      chainId: 43113,
      gasPrice: 25000000000,
      accounts: {
        mnemonic: mnemonic
      }
    }
  }
};

export default config;
