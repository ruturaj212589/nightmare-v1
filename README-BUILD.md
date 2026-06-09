# Nightmare v1 - Build Guide

## 📦 Creating the EXE

### Quick Method (Recommended)
```bash
cd build
build-quick.bat
```

This creates:
- `output/nightmare-v1.bat` - Console launcher
- `output/nightmare-v1.vbs` - Silent launcher

### Advanced Method (Python)
```bash
python build/PyToExe.py
```

Requires:
- Python 3.8+
- PyInstaller: `pip install pyinstaller`

### Manual Compile
```bash
cd build
compile.bat
```

## 🚀 Running the EXE

### Windows
```cmd
output\nightmare-v1.bat
```

### From anywhere
Add `output/` folder to PATH or run:
```cmd
nightmare-v1.bat
```

## 📋 Features

✅ Add games to Steam library
✅ Batch operations
✅ Dark Nightmare theme
✅ Discord integration
✅ Lua-based and extensible

## 💬 Discord

https://discord.gg/dcjqV6t3sC

## 📝 Educational Purpose

This tool is designed for learning:
- Lua programming
- Game library management
- Steam API integration
- Windows executable creation
