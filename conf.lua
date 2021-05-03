GameEnv = {}

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

    -- Load env.lua
    local env = love.filesystem.load("env.lua")
    if env then
        GameEnv = env()
        GameEnv.loaded = true
    end

    settings.conf("game_settings.json")

    t.window.title = "No Parachute"
    t.window.fullscreen = "fullscreen"

    -- Remove unused modules
    t.modules.math = false
    t.modules.physics = false
    t.modules.thread = false
    t.modules.video = false
end