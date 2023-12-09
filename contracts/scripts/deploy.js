// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  // const tokenAddress = "0x4927261E844E7766a34C01ffb873259a467DEfc0"; //zkevm-inr
  // const tokenAddress = "0x9365813b4077898a1ec058690ad898adb98dcae6"; //celo-inr
  const tokenAddress = "0x6712a40B863c7244B89431D0Cf4AFF1cF202C445"; //mumbai-inr
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
