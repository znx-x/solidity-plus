#include <windows.h>
#include <iostream>
#include <fstream>
#include <string>

// Utility function to convert a narrow string to a wide string
std::wstring stringToWideString(const std::string& str) {
    int count = MultiByteToWideChar(CP_UTF8, 0, str.c_str(), -1, NULL, 0);
    std::wstring wstr(count, 0);
    MultiByteToWideChar(CP_UTF8, 0, str.c_str(), -1, &wstr[0], count);
    return wstr;
}

void clearConsole() {
    // Clears the console window
    system("cls");
}

std::string processLine(const std::string& line) {
    if (line.find("original_input") != std::string::npos) {
        return "solidity_output";
    } // else if (...)
    return line;
}

int main(int argc, char* argv[]) {
    clearConsole();
    
    if (argc < 2) {
        std::cout << "Please provide a valid Solidity+ source file.\n";
        return 1;
    }

    std::wstring inputFilePathW = stringToWideString(argv[1]);
    DWORD dwAttrib = GetFileAttributesW(inputFilePathW.c_str());
    if (dwAttrib == INVALID_FILE_ATTRIBUTES || (dwAttrib & FILE_ATTRIBUTE_DIRECTORY)) {
        std::wcout << L"File not found: " << inputFilePathW << std::endl;
        return 1;
    }

    std::wstring outputFilePathW = inputFilePathW.substr(0, inputFilePathW.rfind(L'.')) + L"_compiled.sol";

    if (GetFileAttributesW(outputFilePathW.c_str()) != INVALID_FILE_ATTRIBUTES) {
        DeleteFileW(outputFilePathW.c_str());
    }

    std::ifstream inputFile(argv[1]);
    std::ofstream outputFile(stringToWideString(argv[1]).begin(), stringToWideString(argv[1]).end());

    if (!inputFile.is_open() || !outputFile.is_open()) {
        std::cout << "Error opening files.\n";
        return 1;
    }

    std::string line;
    while (std::getline(inputFile, line)) {
        std::string processedLine = processLine(line);
        outputFile << processedLine << std::endl;
    }

    std::wcout << L"Compilation complete. Output file: " << outputFilePathW << std::endl;

    return 0;
}
