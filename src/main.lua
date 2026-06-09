-- Nightmare v1 - Main Entry Point
-- Dark-themed Steam Library Manager

local VERSION = "1.0.0"
local DISCORD = "https://discord.gg/dcjqV6t3sC"

-- Load libraries
local steam = require("libs.steam")
local ui = require("libs.ui")
local manifest = require("libs.manifest")

-- Initialize app
local function init()
    print("[Nightmare v1] Starting...")
    ui.setTheme("dark")
    ui.setAccent("#FF0000")  -- Red accent for nightmare theme
    steam.init()
    print("[Nightmare v1] Ready. Discord: " .. DISCORD)
end

-- Load games from manifest
local function loadGames(manifestPath)
    local games = manifest.load(manifestPath)
    for _, game in ipairs(games) do
        steam:addToLibrary(game)
        print("[+] Added: " .. game.name)
    end
end

-- Main UI loop
local function run()
    while ui.isRunning() do
        ui.render()
        
        local event = ui.pollEvent()
        if event then
            if event.type == "button_add" then
                loadGames("manifests/games.json")
            elseif event.type == "button_settings" then
                ui.showSettings()
            elseif event.type == "button_discord" then
                os.execute("start " .. DISCORD)
            end
        end
        
        collectgarbage()
    end
end

-- Entry
init()
run()
