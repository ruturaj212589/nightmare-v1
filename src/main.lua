-- Nightmare v1: Educational Steam Library Manager
-- Main application entry point
-- Purpose: Learn game library management and Steam API integration

local VERSION = "1.0.0"
local DISCORD = "https://discord.gg/dcjqV6t3sC"

-- Load all libraries
local steam = require("libs.steam")
local ui = require("libs.ui")
local manifest = require("libs.manifest")

-- ==================== INITIALIZATION ====================

local function init()
    print("\n" .. string.rep("=", 50))
    print("🌙 NIGHTMARE v1 - Educational Steam Library Manager")
    print("Version: " .. VERSION)
    print("Discord: " .. DISCORD)
    print(string.rep("=", 50) .. "\n")
    
    -- Initialize UI with dark theme
    ui.setTheme("dark")
    ui.setAccent({255, 0, 0})  -- Red accent for nightmare
    
    -- Initialize Steam connection
    steam.init()
    
    print("[✓] Initialization complete\n")
end

-- ==================== GAME LIBRARY FUNCTIONS ====================

local function addGameToLibrary(gameData)
    if not gameData.name or not gameData.appid then
        print("[✗] Error: Invalid game data")
        return false
    end
    
    local success = steam:addToLibrary(gameData)
    if success then
        print("[✓] Added: " .. gameData.name)
        return true
    else
        print("[✗] Failed to add: " .. gameData.name)
        return false
    end
end

local function loadGamesFromManifest(path)
    print("[→] Loading games from manifest: " .. path)
    local games = manifest.load(path)
    
    local count = 0
    for _, game in ipairs(games) do
        if addGameToLibrary(game) then
            count = count + 1
        end
    end
    
    print("[✓] Loaded " .. count .. " games\n")
    return count
end

local function displayLibrary()
    local library = steam:getLibrary()
    
    print("\n📚 Current Library (" .. #library .. " games)")
    print(string.rep("-", 50))
    
    for i, game in ipairs(library) do
        print(string.format("%d. %s (AppID: %d)", i, game.name, game.appid))
    end
    
    print(string.rep("-", 50) .. "\n")
end

-- ==================== BATCH OPERATIONS ====================

local function batchAddGames()
    print("\n[→] Batch Add Games Mode")
    local gamesAdded = 0
    
    repeat
        print("Enter game name (or 'done' to finish):")
        local name = io.read()
        if name == "done" then break end
        
        print("Enter AppID:")
        local appid = tonumber(io.read())
        
        print("Enter game path (optional):")
        local path = io.read()
        
        if addGameToLibrary({name = name, appid = appid, path = path}) then
            gamesAdded = gamesAdded + 1
        end
    until false
    
    print("[✓] Added " .. gamesAdded .. " games\n")
end

-- ==================== MENU SYSTEM ====================

local function showMenu()
    print("\n" .. string.rep("=", 50))
    print("🎮 NIGHTMARE v1 - Main Menu")
    print(string.rep("=", 50))
    print("1. View Library")
    print("2. Add Single Game")
    print("3. Batch Add Games")
    print("4. Load from Manifest")
    print("5. Save Library")
    print("6. Settings")
    print("7. Discord Community")
    print("0. Exit")
    print(string.rep("=", 50))
    print("Select option: ")
end

local function handleMenuChoice(choice)
    if choice == "1" then
        displayLibrary()
    
    elseif choice == "2" then
        print("\nEnter game name:")
        local name = io.read()
        print("Enter AppID:")
        local appid = tonumber(io.read())
        print("Enter game path (optional):")
        local path = io.read()
        
        addGameToLibrary({name = name, appid = appid, path = path})
    
    elseif choice == "3" then
        batchAddGames()
    
    elseif choice == "4" then
        print("\nEnter manifest file path:")
        local path = io.read()
        loadGamesFromManifest(path)
    
    elseif choice == "5" then
        steam:saveConfig()
        print("[✓] Library saved\n")
    
    elseif choice == "6" then
        print("\n⚙️  Settings")
        print("Theme: Dark")
        print("Accent: Red")
        print("Discord: " .. DISCORD .. "\n")
    
    elseif choice == "7" then
        print("\n💬 Join our Discord community:")
        print(DISCORD)
        print("(Open in browser manually)\n")
    
    elseif choice == "0" then
        print("\n[→] Saving and exiting...")
        steam:saveConfig()
        print("[✓] Goodbye!\n")
        return false
    
    else
        print("[✗] Invalid option\n")
    end
    
    return true
end

-- ==================== MAIN LOOP ====================

local function run()
    init()
    
    local running = true
    while running do
        showMenu()
        local choice = io.read()
        running = handleMenuChoice(choice)
    end
end

-- ==================== ENTRY POINT ====================

if arg and arg[1] then
    -- Command line mode
    if arg[1] == "--manifest" and arg[2] then
        init()
        loadGamesFromManifest(arg[2])
        steam:saveConfig()
    elseif arg[1] == "--help" then
        print("Nightmare v1 - Educational Steam Library Manager")
        print("Usage: lua main.lua [options]")
        print("  --manifest <path>    Load games from manifest file")
        print("  --help              Show this help message")
        print("  (no args)           Interactive mode")
    else
        print("Unknown option: " .. arg[1])
        print("Use --help for more information")
    end
else
    -- Interactive mode
    run()
end
