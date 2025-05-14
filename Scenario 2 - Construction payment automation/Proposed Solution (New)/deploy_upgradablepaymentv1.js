const hre = require("hardhat");
async function main() {
    // Deploy Upgradable Payment V1
    const UpgradablePaymentFactory = await hre.ethers.getContractFactory("UpgradablePaymentV1");
    const UpgradablePayment = await UpgradablePaymentFactory.deploy();
    await UpgradablePayment.deployed();
  
    console.log("Upgradable payment solution (V1) deployed to:", UpgradablePayment.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  