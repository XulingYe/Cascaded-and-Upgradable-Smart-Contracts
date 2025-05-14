const hre = require("hardhat");
async function main() {
    // Case 1: Old Payment Solution v1
    const UOldPaymentFactory = await hre.ethers.getContractFactory("OldPaymentV1");
    const OldPayment = await UOldPaymentFactory.deploy();
    await OldPayment.deployed();
  
    console.log("Previous payment solution (V1) deployed to:", OldPayment.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });

    