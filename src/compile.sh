#!/bin/bash

# Calls the environment variables and execute the necessary functions to initialize the compiler.
source ./env.sh

# Validate input file
if [ -z "$1" ]; then
    echo "Please provide a valid Solidity+ source file."
    exit 1
fi

# Check if file path is valid and the file exists.
if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
fi

# Set the output Solidity file path and name.
outputFile="${1%.*}_compiled.sol"

# Checks and clears any old output files before compiling.
if [ -f "$outputFile" ]; then
    rm "$outputFile"
fi

# Call the Python script to perform the compilation
echo "Compiling your Solidity+ file..."
python compiler.py "$1" "$outputFile"

echo "Compilation complete. Output file: $outputFile"
