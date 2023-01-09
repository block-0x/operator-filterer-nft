require('dotenv').config(); 

const config = {
  "INFURA_ID": process.env.INFURA_ID,
  "NODE_URL": process.env.NODE_URL,
  "PRIVATE_KEY": process.env.PRIVATE_KEY,
  "DEPLOYER_ADDRESS": process.env.DEPLOYER_ADDRESS,
  "ERC1155_CONTRACT_ADDRESS": process.env.ERC1155_CONTRACT_ADDRESS,
  "ERC721_CONTRACT_ADDRESS": process.env.ERC721_CONTRACT_ADDRESS,
  "USER1_ADDRESS": process.env.USER1_ADDRESS,
  "USER1_PRIVATE_KEY": process.env.USER1_PRIVATE_KEY,
  "USER2_ADDRESS": process.env.USER2_ADDRESS,
  "USER2_PRIVATE_KEY": process.env.USER2_PRIVATE_KEY,
  "USER3_ADDRESS": process.env.USER3_ADDRESS,
  "USER3_PRIVATE_KEY": process.env.USER3_PRIVATE_KEY,
  "ERC1155_ABI": require('../../artifacts/contracts/OpenseaRoyaltyERC1155.sol/OpenseaRoyaltyERC1155.json').abi,
  "ERC721_ABI": require('../../artifacts/contracts/OpenseaRoyaltyERC721.sol/OpenseaRoyaltyERC721.json').abi,
}

module.exports = { config };
