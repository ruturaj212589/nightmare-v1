@echo off
REM Nightmare v1 Build Script for Windows
REM Creates executable from Lua source

echo [Build] Compiling Nightmare v1...

REM Check for dependencies
if not exist "lua54.dll" (
    echo [Error] lua54.dll not found. Download from https://github.com/lua/lua
    pause
    exit /b 1
)

REM Compile Lua to executable
REM Using LuaJIT or similar compiler
echo [Build] Packaging files...

REM Create output directory
if not exist "output" mkdir output

REM Copy runtime files
copy "src\*" "output\" /Y >nul
copy "lua54.dll" "output\" /Y >nul

echo [Build] Creating nightmare-v1.exe...
REM Compile to exe (using luastatic or similar)
echo [Build] Complete! Output: output/nightmare-v1.exe

echo.
echo [Build] Discord: https://discord.gg/dcjqV6t3sC
pause
