const Web3 = require("web3");
const ethers = require('ethers');

const { 
    initWallet,
    initContract
} = require('../service/service.js');

const {
    DEPLOYER_ADDRESS,
} = require("../config/config.js").config;

async function main(to, tokenId, amount) {
    const wallet = await initWallet();
    const {
        erc1155
    } = await initContract(wallet);

    const data = await erc1155.interface.encodeFunctionData('mint', [to, tokenId, amount]);

    console.log('data = ', data);

    const gasPrice = await wallet.getGasPrice();

    console.log('gasPrice = ', String(gasPrice));

    const gas = await wallet.estimateGas({
      to: erc1155.address,
      data: data,
    });

    console.log('gas = ',  String(gas));

    const tx = await erc1155.mint(to, tokenId, amount, {
        gasLimit: await Web3.utils.toHex('500000'),
        gasPrice: '150633647719',
    });

    tx.wait();

    console.log(tx);
}

console.log(DEPLOYER_ADDRESS);

const to = DEPLOYER_ADDRESS;
const tokenId = '10';
const amount = 1;

main(to, tokenId, amount)
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
