-- Example script to add games
-- Usage: lua scripts/add_game.lua

local steam = require("libs.steam")
local manifest = require("libs.manifest")

-- Define games
local games = {
    {
        name = "Dark Souls",
        appid = 211420,
        path = "C:/Games/DarkSouls"
    },
    {
        name = "Hollow Knight",
        appid = 367520,
        path = "C:/Games/HollowKnight"
    }
}

-- Add to library
steam.init()
for _, game in ipairs(games) do
    steam:addToLibrary(game)
end

-- Save
steam:saveConfig()
print("[Scripts] Games added successfully!")
