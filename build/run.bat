@echo off
REM Nightmare v1 - Direct Launcher
REM Run this to start the application

cd /d "%~dp0\.."
title Nightmare v1 - Educational Steam Library Manager
echo.
echo 🌙 NIGHTMARE v1 - Starting...
echo Discord: https://discord.gg/dcjqV6t3sC
echo.
echo.

lua src\main.lua %*

echo.
echo Thank you for using Nightmare v1!
pause
