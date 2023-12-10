require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: __dirname + "/.env" });

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    mumbai: {
      url: "https://polygon-mumbai-bor.publicnode.com",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    zkevm: {
      url: "https://rpc.public.zkevm-test.net",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    arbitrumSep: {
      url: "https://sepolia-rollup.arbitrum.io/rpc",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    base: {
      url: "https://sepolia.base.org",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    scroll: {
      url: "https://sepolia-rpc.scroll.io/",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    celo: {
      url: "https://alfajores-forno.celo-testnet.org",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    mantle: {
      url: "https://rpc.testnet.mantle.xyz",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
  },
  etherscan: {
    apiKey: process.env.ZKEVMSCAN_API_KEY,
  },
  sourcify: {
    enabled: true,
  },
};

/*
ZETA Chain
MANTLE
CELO
XDC
*/
