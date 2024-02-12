#!/bin/bash

# Accepts a line as input
inputLine="$1"

# Superset of Functions
# ~ Reads and recompiles the Solidity+ syntax and semantics to Solidity.
modifiedLine="${inputLine/set license =/\/\/ SPDX-License-Identifier:}"
modifiedLine="${modifiedLine/set compiler =/pragma solidity ^}"
modifiedLine="${modifiedLine/call =/import}"
modifiedLine="${modifiedLine/use interface erc20 =/import @openzeppelin/contracts/token/ERC20/IERC20.sol;}"

# Output the modified line
echo "$modifiedLine"
