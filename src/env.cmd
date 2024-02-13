:: Environment Variables
@echo off
set "initialize=cls"
set "setLocal=setlocal enabledelayedexpansion"
set /p version=<version.ver

:: Window Title and Version
title Solidity+
echo Solidity+ v.%version%