const hre = require("hardhat");
async function main() {
    // Deploy Data Smart Contract
    const DSCFactory = await hre.ethers.getContractFactory("DataSmartContract");
    const DataSmartContract = await DSCFactory.deploy();
    await DataSmartContract.deployed();
  
    console.log("Data Smart Contract deployed to:", DataSmartContract.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  