#!/bin/bash

# Environment Variables
set -o pipefail  # Ensures the exit status of a pipeline is the status of the last command to exit with a non-zero status.
shopt -s expand_aliases  # Enables the use of aliases within the script.

# Read version from .ver file
if [ -f ".ver" ]; then
    read -r version < version.ver
else
    echo ".ver file not found"
    exit 1
fi

setLocal() {
    set -o nounset  # Treat unset variables and parameters as an error.
    set -o errexit  # Exit immediately if a command exits with a non-zero status.
}

echo "Solidity+ v$version"

# Export any variables or functions that should be globally available after sourcing this script
export version
