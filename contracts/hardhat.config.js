require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: __dirname + "/.env" });

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks: {
    mumbai: {
      url: process.env.MUMBAI_ALCHEMY_URL,
      accounts: [`0x${process.env.MUMBAI_DEPLOYER_PRIV_KEY}`],
    },
  },
};
