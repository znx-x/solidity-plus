:: Superset of Functions
:: ~ Reads and recompiles the Solidity+ syntax and semantics to Solidity.

:: Simplify header syntax
set "line=!line: set license = // SPDX-License-Identifier: !"
set "line=!line: set compiler = pragma solidity ^!"
set "line=!line: call = import !"

:: OpenZeppelin imports
set "line=!line: use ETH ERC20 = import @openzeppelin/contracts/token/ERC20/IERC20.sol; !"

:: Simplify visibility and mutability keywords
set "line=!line: visible = public !"
set "line=!line: hidden = private !"
set "line=!line: changeable = nonpayable !"
set "line=!line: constant = view !"
set "line=!line: immutable = pure !"
set "line=!line: protected = internal !"

:: Type simplifications
set "line=!line: num = uint256 !"
set "line=!line: account = address !"
set "line=!line: num8 = uint8 !"
set "line=!line: num16 = uint16 !"
set "line=!line: num32 = uint32 !"
set "line=!line: num64 = uint64 !"

:: Simplify function modifiers (example for onlyOwner)
set "line=!line: restrictedToOwner = modifier onlyOwner { require(msg.sender == owner, \"Not the owner\"); _; } !"

:: Simplify event declaration and emission
set "line=!line: trigger = emit !"

:: Custom syntax for error handling
set "line=!line: error = revert with !"

:: Inline assembly blocks
set "line=!line: asm = assembly !"

:: Simplify variable storage locations
set "line=!line: mem = memory !"
set "line=!line: storage = storage !"

:: Indicate function overloading with a simple keyword
set "line=!line: overloaded = /* overloaded */ !"