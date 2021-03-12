local settings = require("utils.settings")

local function fixDpiAwareness()
    local ffi = require("ffi")

    ffi.cdef([[
        int SetProcessDpiAwareness(int);
    ]])

    local shcore = ffi.load("shcore")
    shcore.SetProcessDpiAwareness(2)
end

local function getSettingsValue(name, defaultValue)
    local value = settings.get(name)
    if value == nil then
        return defaultValue
    end

    return value
end

function love.conf(t)
    pcall(fixDpiAwareness)

    love.filesystem.setIdentity("no_parachute")
    t.identity = "no_parachute"

    settings.conf("game_settings.json")

    t.window.title = "No Parachute"
    t.window.usedpiscale = false
    t.window.resizable = true

    -- Load settings
    t.window.x = getSettingsValue("window_x", nil)
    t.window.y = getSettingsValue("window_y", nil)
    t.window.display = getSettingsValue("display", 1)
    t.window.vsync = getSettingsValue("vsync", true)
    t.window.width = getSettingsValue("window_width", 1024)
    t.window.height = getSettingsValue("window_height", 768)

    local windowMode = getSettingsValue("window_mode", "borderless")
    t.window.fullscreen = windowMode ~= "windowed"
    if windowMode == "borderless" then
        t.window.width = 0
        t.window.height = 0
        t.window.fullscreentype = "desktop"
    elseif windowMode == "fullscreen" then
        t.window.width = 0
        t.window.height = 0
        t.window.fullscreentype = "exclusive"
    end

    -- Remove unused modules
    t.modules.math = false
    t.modules.physics = false
    t.modules.thread = false
    t.modules.touch = false
    t.modules.video = false
end