const { task } = require("hardhat/config");

task("deploy721", "Deploy 721")
  .addOptionalParam("number", "number of contracts", 5, types.int)
  .setAction(async (taskArgs, hre) => {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
  
    const erc721 = await hre.ethers.getContractFactory("VNGCharacter");
    for(let i = 1; i <= taskArgs.number; i++){
        const erc721Deployed = await erc721.deploy();  
        console.log("ERC721 address:", erc721Deployed.address);
        await erc721Deployed.deployed();
    }
});

task("deploy1155", "Deploy 1155")
  .addOptionalParam("number", "number of contracts", 5, types.int)
  .setAction(async (taskArgs, hre) => {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
  
    const erc1155 = await hre.ethers.getContractFactory("VNGHero1155");
    for(let i = 1; i <= taskArgs.number; i++){
        const erc1155Deployed = await erc1155.deploy();  
        console.log("ERC1155 address:", erc1155Deployed.address);
        await erc1155Deployed.deployed();
    }
});