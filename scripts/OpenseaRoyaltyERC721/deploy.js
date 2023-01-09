const hre = require("hardhat");

async function main() {
  const ERC721 = await hre.ethers.getContractFactory("OpenseaRoyaltyERC721");
  const erc721 = await ERC721.deploy();

  await erc721.deployed();

  console.log(
    `erc721 deployed to ${erc721.address}`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
