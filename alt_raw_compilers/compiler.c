#include <windows.h>
#include <stdio.h>
#include <string.h>

void clearConsole() {
    // Clears the console window
    system("cls");
}

void processLine(char* line) {
    // Replace Solidity+ syntax with Solidity syntax
    if (strstr(line, "original_input")) {
        strcpy(line, "solidity_output");
    } //else if (...)
}

int main(int argc, char *argv[]) {
    clearConsole();
    
    if (argc < 2) {
        printf("Please provide a valid Solidity+ source file.\n");
        return 1;
    }

    DWORD dwAttrib = GetFileAttributes(argv[1]);
    if (dwAttrib == INVALID_FILE_ATTRIBUTES || (dwAttrib & FILE_ATTRIBUTE_DIRECTORY)) {
        printf("File not found: %s\n", argv[1]);
        return 1;
    }

    char outputFile[MAX_PATH];
    snprintf(outputFile, MAX_PATH, "%s_compiled.sol", argv[1]);

    if (GetFileAttributes(outputFile) != INVALID_FILE_ATTRIBUTES) {
        DeleteFile(outputFile);
    }

    FILE* inputFile = fopen(argv[1], "r");
    FILE* outputFilePtr = fopen(outputFile, "w");

    if (!inputFile || !outputFilePtr) {
        printf("Error opening files.\n");
        return 1;
    }

    char line[1024];
    while (fgets(line, sizeof(line), inputFile)) {
        processLine(line); // Transform Solidity+ syntax to Solidity syntax
        fprintf(outputFilePtr, "%s", line);
    }

    fclose(inputFile);
    fclose(outputFilePtr);
    printf("Compilation complete. Output file: %s\n", outputFile);

    return 0;
}
