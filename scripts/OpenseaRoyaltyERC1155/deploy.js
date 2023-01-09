const hre = require("hardhat");

async function main() {
  const ERC1155 = await hre.ethers.getContractFactory("OpenseaRoyaltyERC1155");
  const erc1155 = await ERC1155.deploy();

  await erc1155.deployed();

  console.log(
    `erc1155 deployed to ${erc1155.address}`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
