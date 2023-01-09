require('dotenv').config(); 
require('@nomiclabs/hardhat-waffle');
require("@nomiclabs/hardhat-ethers");
require("hardhat-gas-reporter");
require("@nomiclabs/hardhat-etherscan");
require("solidity-coverage");
require("hardhat-deploy");
require('@openzeppelin/hardhat-upgrades');

const fs = require('fs');
const projectId = process.env.INFURA_ID;
const privateKey = process.env.PRIVATE_KEY;

module.exports = {
  defaultNetwork: 'hardhat',
  networks: {
    local: {
      chainId: 31337,
      url: 'http://localhost:8545/',
    },
    ropsten: {
      url: `https://ropsten.infura.io/v3/${projectId}`,
      accounts: [privateKey]
    },
    mumbai: {
      url: `https://polygon-mumbai.infura.io/v3/${projectId}`,
      accounts: [privateKey]
    },
    goerli: {
      url: `https://goerli.infura.io/v3/${projectId}`,
      accounts: [privateKey]
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/${projectId}`,
      accounts: [privateKey]
    }
  },

  solidity: {
    version: '0.8.9',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
