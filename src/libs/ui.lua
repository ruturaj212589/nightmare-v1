-- Nightmare v1 UI Engine
-- Dark theme graphics

local ui = {}
ui.running = true
ui.theme = "dark"
ui.accent = "#FF0000"

-- Color scheme for dark theme
local COLORS = {
    bg = {20, 20, 20},           -- Dark background
    panel = {35, 35, 35},        -- Darker panels
    text = {220, 220, 220},      -- Light text
    accent = {255, 0, 0},        -- Red accent
    border = {50, 50, 50}        -- Border color
}

function ui.setTheme(theme)
    ui.theme = theme
    print("[UI] Theme set to: " .. theme)
end

function ui.setAccent(color)
    ui.accent = color
end

function ui.render()
    -- Render UI elements
    -- Draw background
    -- Draw panels
    -- Draw buttons
end

function ui.isRunning()
    return ui.running
end

function ui.pollEvent()
    -- Poll input events
    return nil
end

function ui.showSettings()
    print("[UI] Opening settings...")
end

return ui
