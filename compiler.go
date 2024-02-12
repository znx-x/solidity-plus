package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func clearConsole() {
	cmd := exec.Command("cmd", "/c", "cls")
	cmd.Stdout = os.Stdout
	cmd.Run()
}

func processLine(line string) string {
	if strings.Contains(line, "set license =") {
		return "// SPDX-License-Identifier: "
	} else if strings.Contains(line, "set compiler =") {
		return "pragma solidity ^"
	} else if strings.Contains(line, "call =") {
		return "import "
	} else if strings.Contains(line, "use interface erc20 =") {
		return "import @openzeppelin/contracts/token/ERC20/IERC20.sol; "
	}
	return line
}

func main() {
	clearConsole()

	if len(os.Args) < 2 {
		fmt.Println("Please provide a valid Solidity+ source file.")
		os.Exit(1)
	}

	inputFilePath := os.Args[1]
	outputFilePath := strings.TrimSuffix(inputFilePath, ".sol") + "_compiled.sol"

	// Check if input file exists
	if _, err := os.Stat(inputFilePath); os.IsNotExist(err) {
		fmt.Printf("File not found: %s\n", inputFilePath)
		os.Exit(1)
	}

	// Delete any existing output file
	if _, err := os.Stat(outputFilePath); err == nil {
		os.Remove(outputFilePath)
	}

	inputFile, err := os.Open(inputFilePath)
	if err != nil {
		fmt.Println("Error opening input file:", err)
		os.Exit(1)
	}
	defer inputFile.Close()

	outputFile, err := os.Create(outputFilePath)
	if err != nil {
		fmt.Println("Error creating output file:", err)
		os.Exit(1)
	}
	defer outputFile.Close()

	scanner := bufio.NewScanner(inputFile)
	writer := bufio.NewWriter(outputFile)

	for scanner.Scan() {
		line := scanner.Text()
		processedLine := processLine(line)
		writer.WriteString(processedLine + "\n")
	}

	if err := writer.Flush(); err != nil {
		fmt.Println("Error writing to output file:", err)
		os.Exit(1)
	}

	fmt.Printf("Compilation complete. Output file: %s\n", outputFilePath)
}
