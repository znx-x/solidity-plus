#!/bin/bash

# Calls the environment variables and execute the necessary functions to initialize the compiler.
source ./env.sh
clear
setLocal

# File Validations
# ~ Check for the input file.
if [ -z "$1" ]; then
    echo "Please provide a valid Solidity+ source file."
    exit 1
fi

# ~ Check if file path is valid and the file exists.
if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
fi

# ~ Set the output Solidity file path and name.
outputFile="${1%.*}_compiled.sol"

# ~ Checks and clears any old output files before compiling.
if [ -f "$outputFile" ]; then
    rm "$outputFile"
fi

# Compiler
while IFS= read -r line || [[ -n "$line" ]]; do
    line=$(source ./supersetCompiler.sh "$line")

    # ~ Check and remove leading and trailing spaces.
    line=$(echo "$line" | xargs)

    # ~ Check if line is empty or not after trimming.
    if [ -z "$line" ]; then
        echo "" >> "$outputFile"
    else
        echo "$line" >> "$outputFile"
    fi
done < "$1"

echo "Compilation complete. Output file: $outputFile"
