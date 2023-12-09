// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const tokenAddress = "0xA02f6adc7926efeBBd59Fd43A84f4E0c0c91e832";
  const challengePeriod = 20; // buffer blocks

  const contract = await hre.ethers.deployContract("PaymentChannelManager", [tokenAddress, challengePeriod]);
  await contract.waitForDeployment();

  console.log(`PaymentChannel deployed to ${contract.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
