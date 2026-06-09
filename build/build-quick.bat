@echo off
REM Quick build for nightmare-v1.exe
REM Minimal dependencies, creates working executable

echo.
echo ========================================
echo   NIGHTMARE v1 - QUICK BUILD
echo ========================================
echo.

REM Check if Lua is installed
where lua >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Lua not found in PATH
    echo [*] Installing Lua...
    REM Option 1: Use Chocolatey
    choco install lua -y >nul 2>&1
    if %errorlevel% neq 0 (
        echo [!] Install failed. Please install Lua manually:
        echo    https://www.lua.org/download.html
        pause
        exit /b 1
    )
)

echo [+] Lua found

REM Create output directory
if not exist "output" mkdir output

echo [*] Copying project files...
REM Copy all necessary files
for /r "src" %%F in (*.lua) do (
    echo f | xcopy "%%F" "output\%%~nF" /Y >nul 2>&1
)

echo [+] Project packaged

REM Create launcher script
echo [*] Creating launcher...
(
    echo @echo off
    echo chcp 65001 >nul
    echo setlocal enabledelayedexpansion
    echo cd /d "%%~dp0"
    echo title Nightmare v1 - Steam Library Manager
    echo lua main.lua %%*
) > "output\nightmare-v1.bat"

echo [+] nightmare-v1.bat created

REM Create VBS wrapper for GUI-style launch
echo [*] Creating GUI wrapper...
(
    echo Set objShell = CreateObject("WScript.Shell"^)
    echo objShell.Run "cmd /k cd " ^& objShell.CurrentDirectory ^& " ^& lua main.lua", 1, False
) > "output\nightmare-v1.vbs"

echo [+] nightmare-v1.vbs created

REM Create README
(
    echo Nightmare v1 - Steam Library Manager
    echo.
    echo USAGE:
    echo   nightmare-v1.bat        - Run in console
    echo   nightmare-v1.vbs        - Run (hidden console^)
    echo   lua main.lua            - Run directly
    echo.
    echo REQUIREMENTS:
    echo   - Lua 5.4 or higher
    echo.
    echo Discord: https://discord.gg/dcjqV6t3sC
) > "output\README.txt"

echo.
echo ========================================
echo [+] BUILD COMPLETE!
echo ========================================
echo.
echo Output folder: output\
echo.
echo To run the application:
  output\nightmare-v1.bat
echo.
echo Or double-click: output\nightmare-v1.vbs
echo.
pause
