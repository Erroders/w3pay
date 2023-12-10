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
      url: "https://arbitrum-goerli.publicnode.com",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    base: {
      url: "https://base-goerli.blockpi.network/v1/rpc/public",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
    scrollSepolia: {
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
    zeta: {
      url: "https://zetachain-athens-evm.blockpi.network/v1/rpc/public",
      accounts: [`0x${process.env.DEPLOYER_PRIV_KEY}`],
    },
  },
  etherscan: {
    apiKey: "5CMRUAC3EFHJ3759UHPXUXTR9P5Q235R2A",
  },
  sourcify: {
    enabled: true,
  },
  // etherscan: {
  //   apiKey: {
  //     scrollSepolia: "5CMRUAC3EFHJ3759UHPXUXTR9P5Q235R2A",
  //   },
  //   customChains: [
  //     {
  //       network: "scrollSepolia",
  //       chainId: 534351,
  //       urls: {
  //         apiURL: "https://sepolia-blockscout.scroll.io/api",
  //         browserURL: "https://sepolia-blockscout.scroll.io/",
  //       },
  //     },
  //   ],
  // },
};

/*
ZETA Chain
MANTLE
CELO
XDC
*/
