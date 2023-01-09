// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { OperatorFilterer } from "./OperatorFilterer.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IERC2981, ERC2981 } from "@openzeppelin/contracts/token/common/ERC2981.sol";

contract OpenseaRoyaltyERC721 is ERC721, OperatorFilterer, Ownable, ERC2981 {
	bool public operatorFilteringEnabled;

	constructor() ERC721("OpenseaRoyalty", "OR") {
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

	function approve(
		address operator,
		uint256 tokenId
	) public override onlyAllowedOperatorApproval(operator) {
		super.approve(operator, tokenId);
	}

	function transferFrom(
		address from,
		address to,
		uint256 tokenId
	) public override onlyAllowedOperator(from) {
		super.transferFrom(from, to, tokenId);
	}

	function safeTransferFrom(
		address from,
		address to,
		uint256 tokenId
	) public override onlyAllowedOperator(from) {
		super.safeTransferFrom(from, to, tokenId);
	}

	function safeTransferFrom(
		address from,
		address to,
		uint256 tokenId,
		bytes memory data
	) public override onlyAllowedOperator(from) {
		super.safeTransferFrom(from, to, tokenId, data);
	}

	function tokenURI(uint256) public pure override returns (string memory) {
		return "";
	}

	function supportsInterface(
		bytes4 interfaceId
	) public view virtual override(ERC721, ERC2981) returns (bool) {
		return
			ERC721.supportsInterface(interfaceId) ||
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
}
