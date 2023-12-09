require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: __dirname + "/.env" });

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    mumbai: {
      url: process.env.POLYGON_ALCHEMY_URL || "https://rpc.ankr.com/polygon_mumbai",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    zkevm: {
      url: process.env.ZKEVM_ALCHEMY_URL || "https://rpc.public.zkevm-test.net",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    arbitrum: {
      url: process.env.ARBITRUM_ALCHEMY_URL || "https://sepolia-rollup.arbitrum.io/rpc",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    base: {
      url: process.env.BASE_ALCHEMY_URL || "https://sepolia.base.org",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    scroll: {
      url: process.env.SCROLL_NODE_URL || "https://sepolia-rpc.scroll.io/",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
  },
};

/*
ZETA Chain
MANTLE
CELO
XDC
*/
