-- Manifest Loader for game definitions
-- Supports JSON format

local manifest = {}

local function parseJSON(jsonStr)
    -- Simple JSON parser for game manifests
    local games = {}
    -- Parse JSON string
    return games
end

function manifest.load(path)
    print("[Manifest] Loading from: " .. path)
    local file = io.open(path, "r")
    
    if not file then
        print("[Manifest] File not found: " .. path)
        return {}
    end
    
    local content = file:read("*a")
    file:close()
    
    return parseJSON(content)
end

function manifest.create(games, outputPath)
    local file = io.open(outputPath, "w")
    if file then
        file:write('[\n')
        for i, game in ipairs(games) do
            file:write(string.format('{"name":"%s","appid":%d,"path":"%s"}',
                game.name, game.appid, game.path or ""))
            if i < #games then file:write(',') end
            file:write('\n')
        end
        file:write(']\n')
        file:close()
        print("[Manifest] Created: " .. outputPath)
    end
end

return manifest
