@echo off
:: Set environment variables and initialize compiler settings
call .\env
%initialize%
%setLocal%

:: Validate input file
if "%~1"=="" (
    echo Please provide a valid Solidity+ source file.
    exit /b
)

if not exist "%~1" (
    echo File not found: %~1
    exit /b
)

:: Define the output Solidity file path and name
set "outputFile=%~dpn1_compiled.sol"

:: Check and clear any old output files before compiling
if exist "%outputFile%" del "%outputFile%"

:: Call the Python script to perform the compilation
echo Compiling your Solidity+ file...
python compiler.py "%~1" "%outputFile%"

echo Output file: %outputFile%