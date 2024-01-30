:: Calls the environment variables and execute the necessary
:: functions to initialize the compiler.
call .\env
%initialize%
%setLocal%

:: File Validations

:: ~ Check for the input file.
if "%~1"=="" (
    echo Please provide a valid Solidity+ source file.
    exit /b
)

:: ~ Check if file path is valid and the file exists.
if not exist "%~1" (
    echo File not found: %~1
    exit /b
)

:: ~ Set the output Solidity file path and name.
set "outputFile=%~dpn1_compiled.sol"

:: ~ Checks and clears any old output files before compiling.
if exist "%outputFile%" del "%outputFile%"

:: Compiler
for /f "tokens=*" %%i in (%~1) do (
    set "line= %%i "
    call .\supersetCompiler

    :: ~ Check and remove leading and trailing spaces.
    for /f "tokens=* delims= " %%x in ("!line!") do set "line=%%x"

    :: ~ Check if line is empty or not after trimming.
    if "!line!"=="" (
        echo.>>"%outputFile%"
    ) else (
        echo !line!>>"%outputFile%"
    )
)

echo Compilation complete. Output file: %outputFile%
