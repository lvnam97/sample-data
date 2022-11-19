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
      accounts: ["d62bb6ee1185760928be7ac485595d1b7b8f8224afec47b232d7da6eb860c209"]
    },
    bsctest: {
      url: `https://rpc.bsc-test.verichains.xyz`,
      accounts: ["d62bb6ee1185760928be7ac485595d1b7b8f8224afec47b232d7da6eb860c209"]
    },
    avaxtest: {
      url: `https://rpc.avax-test.verichains.xyz`,
      accounts: ["d62bb6ee1185760928be7ac485595d1b7b8f8224afec47b232d7da6eb860c209"]
    }
  }
};
