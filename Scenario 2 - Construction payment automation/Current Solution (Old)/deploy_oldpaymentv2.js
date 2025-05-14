const hre = require("hardhat");
async function main() {
    // Deploy Old Payment Solution v2
    const UOldPaymentFactory = await hre.ethers.getContractFactory("OldPaymentV2");
    const OldPayment = await UOldPaymentFactory.deploy();
    await OldPayment.deployed();
  
    console.log("Previous payment solution (V2) deployed to:", OldPayment.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });