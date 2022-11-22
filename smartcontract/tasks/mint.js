const { task } = require("hardhat/config");

function getRandomArbitrary(min, max) {
  return Math.round(Math.random() * (max - min) + min);
}

task("mint721", "Mint 721")
  .addPositionalParam("contractAddress", "address of contract", "", types.string)
  .addPositionalParam("number", "number of nfts", 1, types.int)
  .setAction(async (taskArgs, hre) => {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
    const erc721 = await hre.ethers.getContractFactory("VNGCharacter");
    const erc721Instance = erc721.attach(taskArgs.contractAddress);
    
    console.log(`Mint NFT of ${taskArgs.contractAddress}`);
    for(i = 1; i <= taskArgs.number; i++){
      console.log(`${i} Minting....`)
      let rs = await erc721Instance.mintNFT(
        getRandomArbitrary(0, 1),
        getRandomArbitrary(0, 7),
        getRandomArbitrary(0, 3),
        getRandomArbitrary(0, 3),
        getRandomArbitrary(0, 5),
        `https://image.nft.xwg.games/1/${getRandomArbitrary(1, 1000)}`,
        "0x0000000000000000000000000000000000000000000000000000000000000000"
      );
      await rs.wait();
    }
});

task("mint1155", "Mint 1155")
  .addPositionalParam("contractAddress", "address of contract", "", types.string)
  .addPositionalParam("number", "number of nfts", 1, types.int)
  .setAction(async (taskArgs, hre) => {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
    const erc1155 = await hre.ethers.getContractFactory("VNGHero1155");
    const erc1155Instance = erc1155.attach(taskArgs.contractAddress);
    
    console.log(`Mint NFT of ${taskArgs.contractAddress}`);
    for(i = 1; i <= taskArgs.number; i++){
      console.log(`${i} Minting....`)
      let rs = await erc1155Instance.mint(
        getRandomArbitrary(100, 2000),
        getRandomArbitrary(0, 1),
        getRandomArbitrary(0, 7),
        getRandomArbitrary(0, 3),
        getRandomArbitrary(0, 3),
        getRandomArbitrary(0, 5),
        `https://image.nft.xwg.games/1/${getRandomArbitrary(1, 1000)}`
      );
      await rs.wait();
    }
});

task("mint1155Ver2", "Mint 1155")
  .addPositionalParam("contractAddress", "address of contract", "", types.string)
  .addPositionalParam("tokenId", "tokenId", 1, types.int)
  .addPositionalParam("number", "number of nfts", 1, types.int)
  .setAction(async (taskArgs, hre) => {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
    const erc1155 = await hre.ethers.getContractFactory("VNGHero1155");
    const erc1155Instance = erc1155.attach(taskArgs.contractAddress);
    
    console.log(`Mint NFT of ${taskArgs.contractAddress}`);
    for(i = 1; i <= taskArgs.number; i++){
      console.log(`${i} Minting....`)
      let rs = await erc1155Instance.mintVer2(taskArgs.tokenId, taskArgs.number);
      await rs.wait();
    }
});

task("mintERC20", "Mint 20")
  .addPositionalParam("contractAddress", "address of contract", "", types.string)
  .addPositionalParam("number", "amount tokens", 1, types.int)
  .addPositionalParam("for", "address of user", "", types.string)
  .setAction(async (taskArgs, hre) => {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
    const erc20 = await hre.ethers.getContractFactory("TokenERC20Example");
    const erc20Instance = erc20.attach(taskArgs.contractAddress);
    
    console.log(`Mint token of ${taskArgs.contractAddress}`);
    let rs = await erc20Instance.mint(
      taskArgs.for == "" ? deployer.address : taskArgs.for,
      hre.ethers.utils.parseEther(taskArgs.number.toString()).toString()
    );
    await rs.wait();
});