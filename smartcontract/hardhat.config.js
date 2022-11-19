require("@nomicfoundation/hardhat-toolbox");

require("./tasks/deploy");
require("./tasks/mint");

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    version: "0.8.12",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,

      },
      viaIR: true
    },
  },
  networks: {
    dev: {
      url: `https://rpc.dev.verichains.xyz`,
      accounts: ["your_private_key"]
    },
    bsctest: {
      url: `https://rpc.bsc-test.verichains.xyz`,
      accounts: ["your_private_key"]
    },
    avaxtest: {
      url: `https://rpc.avax-test.verichains.xyz`,
      accounts: ["your_private_key"]
    }
  }
};
