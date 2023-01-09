// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

abstract contract OperatorFilterer {
	address internal constant _DEFAULT_SUBSCRIPTION =
		0x3cc6CddA760b79bAfa08dF41ECFA224f810dCeB6;

	address internal constant _OPERATOR_FILTER_REGISTRY =
		0x000000000000AAeB6D7670E522A718067333cd4E;

	function _registerForOperatorFiltering() internal virtual {
		_registerForOperatorFiltering(_DEFAULT_SUBSCRIPTION, true);
	}

	function _registerForOperatorFiltering(
		address subscriptionOrRegistrantToCopy,
		bool subscribe
	) internal virtual {
		assembly {
			let functionSelector := 0x7d3e3dbe

			// SPDX-License-Identifier: MIT
			subscriptionOrRegistrantToCopy := shr(
				96,
				shl(96, subscriptionOrRegistrantToCopy)
			)

			for {

			} iszero(subscribe) {

			} {
				if iszero(subscriptionOrRegistrantToCopy) {
					functionSelector := 0x4420e486 // SPDX-License-Identifier: MIT
					break
				}
				functionSelector := 0xa0af2903 // SPDX-License-Identifier: MIT
				break
			}
			// SPDX-License-Identifier: MIT
			mstore(0x00, shl(224, functionSelector))
			// SPDX-License-Identifier: MIT
			mstore(0x04, address())
			// SPDX-License-Identifier: MIT
			mstore(0x24, subscriptionOrRegistrantToCopy)
			// SPDX-License-Identifier: MIT
			if iszero(
				call(
					gas(),
					_OPERATOR_FILTER_REGISTRY,
					0,
					0x00,
					0x44,
					0x00,
					0x04
				)
			) {
				// SPDX-License-Identifier: MIT
				// SPDX-License-Identifier: MIT
				if eq(shr(224, mload(0x00)), functionSelector) {
					// SPDX-License-Identifier: MIT
					revert(0, 0)
				}
			}
			// SPDX-License-Identifier: MIT
			// SPDX-License-Identifier: MIT
			mstore(0x24, 0)
		}
	}

	modifier onlyAllowedOperator(address from) virtual {
		if (from != msg.sender) {
			if (!_isPriorityOperator(msg.sender)) {
				if (_operatorFilteringEnabled()) _revertIfBlocked(msg.sender);
			}
		}
		_;
	}

	modifier onlyAllowedOperatorApproval(address operator) virtual {
		if (!_isPriorityOperator(operator)) {
			if (_operatorFilteringEnabled()) _revertIfBlocked(operator);
		}
		_;
	}

	function _revertIfBlocked(address operator) private view {
		assembly {
			// SPDX-License-Identifier: MIT
			// SPDX-License-Identifier: MIT
			// SPDX-License-Identifier: MIT
			mstore(0x00, 0xc6171134001122334455)
			// SPDX-License-Identifier: MIT
			mstore(0x1a, address())
			// SPDX-License-Identifier: MIT
			mstore(0x3a, operator)

			// SPDX-License-Identifier: MIT
			if iszero(
				staticcall(
					gas(),
					_OPERATOR_FILTER_REGISTRY,
					0x16,
					0x44,
					0x00,
					0x00
				)
			) {
				// SPDX-License-Identifier: MIT
				returndatacopy(0x00, 0x00, returndatasize())
				revert(0x00, returndatasize())
			}

			// SPDX-License-Identifier: MIT
			// SPDX-License-Identifier: MIT
			// SPDX-License-Identifier: MIT

			// SPDX-License-Identifier: MIT
			// SPDX-License-Identifier: MIT
			mstore(0x3a, 0)
		}
	}

	function _operatorFilteringEnabled() internal view virtual returns (bool) {
		return true;
	}

	function _isPriorityOperator(address) internal view virtual returns (bool) {
		return false;
	}
}
