# 🌙 Nightmare v1 - Steam Library Tool

Dark-themed educational Steam library manager with Lua scripting support.

## 🎮 Features
- Add games to Steam library automatically
- 🌙 Dark Nightmare UI theme
- 🔧 Lua scripting engine
- 📦 Manifest-based game loader
- 💬 Discord Community: https://discord.gg/dcjqV6t3sC

## 📥 Installation
1. Download `nightmare-v1.exe`
2. Run the executable
3. Add games via Lua scripts or UI

## 🔧 Usage
```lua
-- scripts/add_game.lua
local game = {
  name = "Game Name",
  appid = 123456,
  path = "C:/Games/GameName"
}

steam:addToLibrary(game)
```

## 📚 Libraries
- Lua 5.4
- SFML (Graphics)
- cURL (Web requests)

## 📋 Educational Purpose Only
For learning game automation and Lua scripting.
