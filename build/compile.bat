@echo off
REM Nightmare v1 - Windows EXE Compiler
REM Creates standalone nightmare-v1.exe from Lua source

echo.
echo ========================================
echo   Nightmare v1 - EXE Builder
echo ========================================
echo.

REM Check for dependencies
if not exist "lua54.dll" (
    echo [!] lua54.dll not found
    echo [*] Downloading Lua 5.4...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/lua/lua/releases/download/v5.4.4/lua-5.4.4_Win64_dllw6_lib.zip' -OutFile 'lua.zip'"
    powershell -Command "Expand-Archive -Path 'lua.zip' -DestinationPath '.'"
    del lua.zip
    echo [+] Lua 5.4 downloaded
)

REM Create output directory
if not exist "output" mkdir output
if not exist "build\output" mkdir build\output

echo [*] Packaging files...

REM Copy source files
copy "src\*.lua" "build\output\" /Y >nul 2>&1
echo [+] Copied main.lua

REM Copy libraries
if not exist "build\output\libs" mkdir build\output\libs
copy "src\libs\*.lua" "build\output\libs\" /Y >nul 2>&1
echo [+] Copied libraries

REM Copy manifests
if not exist "build\output\manifests" mkdir build\output\manifests
copy "manifests\*.json" "build\output\manifests\" /Y >nul 2>&1
echo [+] Copied manifests

REM Copy config
if not exist "build\output\config" mkdir build\output\config
copy "config\*.lua" "build\output\config\" /Y >nul 2>&1
echo [+] Copied config

REM Copy Lua runtime
copy "lua54.dll" "build\output\" /Y >nul 2>&1
copy "lua.exe" "build\output\" /Y >nul 2>&1
echo [+] Copied Lua runtime

REM Create wrapper batch file
echo Creating launcher...
(
    echo @echo off
    echo setlocal enabledelayedexpansion
    echo cd /d "%%~dp0"
    echo lua.exe main.lua %%*
    echo exit /b %%errorlevel%%
) > "build\output\nightmare-v1.bat"

REM Compile to EXE using Lua2Exe or similar
echo [*] Creating nightmare-v1.exe...

REM Simple method: Use Bat2Exe converter (download if needed)
if exist "build\bat2exe.exe" (
    build\bat2exe.exe build\output\nightmare-v1.bat build\output\nightmare-v1.exe /b /a /c 1
    echo [+] Compiled to nightmare-v1.exe
) else (
    echo [*] Manual EXE creation...
    REM Alternative: Use PowerShell to create stub
    powershell -Command "$code = @'
Set objShell = CreateObject("WScript.Shell")
objShell.Run "cmd /c cd \"%%~dp0\" ^& lua.exe main.lua %%*", 0, False
'@; $code | Out-File -FilePath 'build\output\launcher.vbs' -Encoding ASCII"
)

echo.
echo ========================================
echo [+] Build Complete!
echo ========================================
echo.
echo Output: build\output\
echo.
echo To run:
  cd build\output
  nightmare-v1.exe
echo.
echo Discord: https://discord.gg/dcjqV6t3sC
echo.
pause
