:: Superset of Functions
:: ~ Reads and recompiles the Solidity+ syntax and semantics to Solidity.
set "line=!line: set license = // SPDX-License-Identifier: !"
set "line=!line: set compiler = pragma solidity ^!"
set "line=!line: call = import !"
set "line=!line: use interface erc20 = import @openzeppelin/contracts/token/ERC20/IERC20.sol; !"
