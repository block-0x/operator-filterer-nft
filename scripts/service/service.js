const ethers = require('ethers');

const {
    INFURA_ID,
    NODE_URL,
    PRIVATE_KEY,
    DEPLOYER_ADDRESS,
    ERC1155_CONTRACT_ADDRESS,
    ERC721_CONTRACT_ADDRESS,
    USER1_ADDRESS,
    USER1_PRIVATE_KEY,
    USER2_ADDRESS,
    USER2_PRIVATE_KEY,
    USER3_ADDRESS,
    USER3_PRIVATE_KEY,
    ERC1155_ABI,
    ERC721_ABI,
} = require("../config/config.js").config;

async function initWallet(prvKey = PRIVATE_KEY) {
    const HTTPSProvider = new ethers.providers.JsonRpcProvider(NODE_URL)

    return await new ethers.Wallet(prvKey, HTTPSProvider)
}

async function initERC1155(wallet) {
    return await new ethers.Contract(ERC1155_CONTRACT_ADDRESS, ERC1155_ABI, wallet)
}

async function initERC721(wallet) {
    return await new ethers.Contract(ERC721_CONTRACT_ADDRESS, ERC721_ABI, wallet)
}

async function initContract(wallet) {
    const erc1155 = await initERC1155(wallet);
    const erc721 = await initERC721(wallet);

    return { erc1155, erc721 }
}

module.exports = { 
    initWallet,
    initContract
};
