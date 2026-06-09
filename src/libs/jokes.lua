-- Joke Generator using external APIs
-- Supports multiple joke sources

local jokes = {}

-- Initialize cURL for HTTP requests
local function getJoke(url)
    local response = ""
    
    -- Use curl command to fetch joke
    local cmd = string.format('curl -s "%s"', url)
    local handle = io.popen(cmd, 'r')
    
    if handle then
        response = handle:read("*a")
        handle:close()
    end
    
    return response
end

-- Parse JSON response (simple parser)
local function parseJSON(jsonStr)
    local joke = {}
    
    -- Extract joke field
    local setup = jsonStr:match('"setup"%s*:%s*"([^"]*)"')
    local delivery = jsonStr:match('"delivery"%s*:%s*"([^"]*)"')
    local joke_text = jsonStr:match('"joke"%s*:%s*"([^"]*)"')
    
    if setup and delivery then
        joke.text = setup .. "\n" .. delivery
        joke.type = "two-part"
    elseif joke_text then
        joke.text = joke_text
        joke.type = "single"
    else
        joke.text = jsonStr:match('"content"%s*:%s*"([^"]*)"') or "No joke found"
        joke.type = "other"
    end
    
    return joke
end

-- JokeAPI.dev - Programming jokes
function jokes.getProgrammingJoke()
    print("[Jokes] Fetching programming joke...")
    local url = "https://official-joke-api.appspot.com/random_joke"
    local response = getJoke(url)
    return parseJSON(response)
end

-- Dad Jokes API
function jokes.getDadJoke()
    print("[Jokes] Fetching dad joke...")
    local url = "https://icanhazdadjoke.com/?format=json"
    local response = getJoke(url)
    
    local joke = {}
    local joke_text = response:match('"joke"%s*:%s*"([^"]*)"')
    joke.text = joke_text or "Why did the dad joke generator break? It couldn't handle the punchline!"
    joke.type = "dad"
    
    return joke
end

-- Random joke (mixed)
function jokes.getRandomJoke()
    print("[Jokes] Fetching random joke...")
    local apis = {
        "https://official-joke-api.appspot.com/random_joke",
        "https://icanhazdadjoke.com/?format=json"
    }
    
    local selected = apis[math.random(1, #apis)]
    local response = getJoke(selected)
    return parseJSON(response)
end

-- Joke of the day
function jokes.getJokeOfDay()
    print("[Jokes] Fetching joke of the day...")
    local url = "https://official-joke-api.appspot.com/jokes/programming/random"
    local response = getJoke(url)
    return parseJSON(response)
end

return jokes
