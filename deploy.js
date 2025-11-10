// scripts/deploy.js
async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with account:", deployer.address);

  const EnergyTrading = await ethers.getContractFactory("EnergyTrading");
  const et = await EnergyTrading.deploy();
  await et.deployed();
  console.log("EnergyTrading deployed to:", et.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
