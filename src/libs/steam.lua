-- Steam Library Manager

local steam = {}
steam.gameList = {}

function steam.init()
    print("[Steam] Initializing Steam API...")
    -- Connect to Steam
end

function steam:addToLibrary(game)
    if not game.name or not game.appid then
        error("Invalid game object")
        return false
    end
    
    table.insert(self.gameList, game)
    print(string.format("[Steam] Added %s (AppID: %d)", game.name, game.appid))
    return true
end

function steam:getLibrary()
    return self.gameList
end

function steam:saveConfig()
    local file = io.open("config/steam.cfg", "w")
    if file then
        for _, game in ipairs(self.gameList) do
            file:write(game.name .. "|" .. game.appid .. "|" .. (game.path or "") .. "\n")
        end
        file:close()
        print("[Steam] Config saved")
    end
end

return steam
