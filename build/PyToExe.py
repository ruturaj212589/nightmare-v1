#!/usr/bin/env python3
"""
Nightmare v1 - Python to EXE Converter
Converts Lua-based Steam Library Manager to standalone Windows EXE
"""

import os
import shutil
import zipfile
import subprocess
import sys
from pathlib import Path

VERSION = "1.0.0"
OUTPUT_DIR = "build/output"
DIST_DIR = "dist"

def create_exe_stub():
    """Create a Python stub that runs Lua"""
    stub_code = '''#!/usr/bin/env python3
import subprocess
import sys
import os

if __name__ == "__main__":
    script_dir = os.path.dirname(os.path.abspath(__file__))
    main_lua = os.path.join(script_dir, "main.lua")
    
    cmd = ["lua.exe", main_lua] + sys.argv[1:]
    result = subprocess.run(cmd, cwd=script_dir)
    sys.exit(result.returncode)
'''
    return stub_code

def copy_files():
    """Copy all necessary files to output directory"""
    print("[*] Copying files...")
    
    # Create directories
    os.makedirs(f"{OUTPUT_DIR}/libs", exist_ok=True)
    os.makedirs(f"{OUTPUT_DIR}/manifests", exist_ok=True)
    os.makedirs(f"{OUTPUT_DIR}/config", exist_ok=True)
    os.makedirs(f"{OUTPUT_DIR}/scripts", exist_ok=True)
    
    # Copy Lua source
    shutil.copy("src/main.lua", f"{OUTPUT_DIR}/main.lua")
    print("  [+] main.lua")
    
    # Copy libraries
    for lib in os.listdir("src/libs"):
        if lib.endswith(".lua"):
            shutil.copy(f"src/libs/{lib}", f"{OUTPUT_DIR}/libs/{lib}")
    print("  [+] libraries")
    
    # Copy manifests
    for manifest in os.listdir("manifests"):
        if manifest.endswith(".json"):
            shutil.copy(f"manifests/{manifest}", f"{OUTPUT_DIR}/manifests/{manifest}")
    print("  [+] manifests")
    
    # Copy config
    for config in os.listdir("config"):
        if config.endswith(".lua"):
            shutil.copy(f"config/{config}", f"{OUTPUT_DIR}/config/{config}")
    print("  [+] config")
    
    # Copy scripts
    if os.path.exists("scripts"):
        for script in os.listdir("scripts"):
            if script.endswith(".lua"):
                shutil.copy(f"scripts/{script}", f"{OUTPUT_DIR}/scripts/{script}")
        print("  [+] scripts")

def create_executable():
    """Create Windows EXE using PyInstaller"""
    print("\n[*] Creating executable...")
    
    # Create stub Python file
    stub_path = f"{OUTPUT_DIR}/nightmare_v1.py"
    with open(stub_path, "w") as f:
        f.write(create_exe_stub())
    
    # Use PyInstaller to create EXE
    cmd = [
        "pyinstaller",
        "--onefile",
        "--console",
        "--name=nightmare-v1",
        "--icon=build/icon.ico" if os.path.exists("build/icon.ico") else "",
        f"--distpath={DIST_DIR}",
        f"--buildpath=build/temp",
        stub_path
    ]
    
    cmd = [c for c in cmd if c]  # Remove empty strings
    
    try:
        subprocess.run(cmd, check=True)
        print("  [+] nightmare-v1.exe created")
        return True
    except subprocess.CalledProcessError:
        print("  [!] PyInstaller failed")
        print("  [*] Using alternative method...")
        return create_batch_exe()

def create_batch_exe():
    """Fallback: Create batch runner"""
    batch_content = '''@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
lua.exe main.lua %*
exit /b %errorlevel%
'''
    
    batch_path = f"{OUTPUT_DIR}/nightmare-v1.bat"
    with open(batch_path, "w") as f:
        f.write(batch_content)
    
    print("  [+] nightmare-v1.bat created")
    print("  [*] Run: nightmare-v1.bat")
    return True

def create_distribution():
    """Create final distribution package"""
    print("\n[*] Creating distribution...")
    
    os.makedirs(DIST_DIR, exist_ok=True)
    
    # Create ZIP archive
    zip_path = f"{DIST_DIR}/nightmare-v1-{VERSION}.zip"
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(OUTPUT_DIR):
            for file in files:
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, OUTPUT_DIR)
                zipf.write(file_path, arcname)
    
    print(f"  [+] {zip_path}")
    return zip_path

def main():
    print("\n" + "="*50)
    print("🌙 Nightmare v1 - EXE Builder")
    print(f"Version: {VERSION}")
    print("="*50 + "\n")
    
    # Clean output
    if os.path.exists(OUTPUT_DIR):
        shutil.rmtree(OUTPUT_DIR)
    
    # Build
    copy_files()
    create_executable()
    create_distribution()
    
    print("\n" + "="*50)
    print("[+] Build Complete!")
    print("="*50)
    print(f"Output: {OUTPUT_DIR}/")
    print(f"Distribution: {DIST_DIR}/nightmare-v1-{VERSION}.zip")
    print("\nDiscord: https://discord.gg/dcjqV6t3sC")
    print()

if __name__ == "__main__":
    main()
