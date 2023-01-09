// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import { ERC1155 } from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import { OperatorFilterer } from "./OperatorFilterer.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IERC2981, ERC2981 } from "@openzeppelin/contracts/token/common/ERC2981.sol";

contract OpenseaRoyaltyERC1155 is ERC1155, OperatorFilterer, Ownable, ERC2981 {
	bool public operatorFilteringEnabled;

	constructor()
		ERC1155(
			"https://gateway.pinata.cloud/ipfs/QmZ7FH13xRK9AQcC6oi5hfipXgDgxdDtXkWuB3mfhonmVr"
		)
	{
		_registerForOperatorFiltering();
		operatorFilteringEnabled = true;

		_setDefaultRoyalty(msg.sender, 500);
	}

	function setApprovalForAll(
		address operator,
		bool approved
	) public override onlyAllowedOperatorApproval(operator) {
		super.setApprovalForAll(operator, approved);
	}

	function safeTransferFrom(
		address from,
		address to,
		uint256 tokenId,
		uint256 amount,
		bytes memory data
	) public override onlyAllowedOperator(from) {
		super.safeTransferFrom(from, to, tokenId, amount, data);
	}

	function safeBatchTransferFrom(
		address from,
		address to,
		uint256[] memory ids,
		uint256[] memory amounts,
		bytes memory data
	) public override onlyAllowedOperator(from) {
		super.safeBatchTransferFrom(from, to, ids, amounts, data);
	}

	function supportsInterface(
		bytes4 interfaceId
	) public view virtual override(ERC1155, ERC2981) returns (bool) {
		return
			ERC1155.supportsInterface(interfaceId) ||
			ERC2981.supportsInterface(interfaceId);
	}

	function setDefaultRoyalty(
		address receiver,
		uint96 feeNumerator
	) public onlyOwner {
		_setDefaultRoyalty(receiver, feeNumerator);
	}

	function setOperatorFilteringEnabled(bool value) public onlyOwner {
		operatorFilteringEnabled = value;
	}

	function _operatorFilteringEnabled() internal view override returns (bool) {
		return operatorFilteringEnabled;
	}

	function _isPriorityOperator(
		address operator
	) internal pure override returns (bool) {
		return operator == address(0x1E0049783F008A0085193E00003D00cd54003c71);
	}

	function mint(address to, uint256 id, uint256 amount) public payable {
		_mint(to, id, amount, "");
	}
}
