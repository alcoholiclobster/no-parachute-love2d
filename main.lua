local argparse = require("lib.argparse")
local ScreenManager = require("ui.ScreenManager")
local joystickManager = require("utils.joystickManager")
local console = require("utils.console")
local mouseUtils = require("utils.mouse")
local musicManager = require("utils.musicManager")
local scheduler = require("utils.scheduler")
local settings = require("core.settings")
local languageUtils = require("utils.language")

GLOBAL_DEBUG_ENABLED = true
GLOBAL_HUD_DISABLED = false

local debugSimulateFrameRate = 30
local debugUpdateDelay = 0

local screenManager

function love.load(arg)
    console.log("love.load()")

    love.filesystem.setIdentity("no_parachute")
    languageUtils.loadLanguage("en")

    settings.load()

    local parser = argparse()
    parser:flag("--debug", "Run game in debug mode")
    parser:option("--level", "Force load game level")
    parser:option("--fps", "Simulate frame rate")
    parser:flag("--fullscreen", "Force fullscreen mode")
    parser:flag("--nohud", "Disable HUD")
    local args = parser:parse(arg)

    GLOBAL_DEBUG_ENABLED = GLOBAL_DEBUG_ENABLED or args.debug
    GLOBAL_HUD_DISABLED = not not args.nohud
    math.randomseed(os.time())

    debugSimulateFrameRate = tonumber(args.fps) or 0

    screenManager = ScreenManager:new()

    if args.level then
        print("Force loading level "..tostring(args.level))
        screenManager:transition("GameScreen", args.level)
    else
        screenManager:transition("MainMenuScreen")
    end
    screenManager.fadeProgress = 0.5

    if args.fullscreen then
        love.window.setFullscreen(true)
    else
        -- love.window.maximize()
    end
end

function love.update(deltaTime)
    if deltaTime > 0.5 then
        return
    end

    scheduler.update(deltaTime)
    mouseUtils.update()
    screenManager:update(deltaTime)
    musicManager:update(deltaTime)

    if GLOBAL_DEBUG_ENABLED and debugSimulateFrameRate > 0 then
        debugUpdateDelay = debugUpdateDelay + deltaTime
        if debugUpdateDelay > (1000 / debugSimulateFrameRate) / 1000 then
            screenManager:emit("update", debugUpdateDelay)
            debugUpdateDelay = 0
        end
    else
        screenManager:emit("update", deltaTime)
    end
end

function love.draw()
    screenManager:emit("draw")
    screenManager:draw()

    console.draw()
end

function love.keypressed(key, ...)
    screenManager:emit("handleKeyPress", key, ...)

    if key == "`" and GLOBAL_DEBUG_ENABLED then
        console.toggle()
    elseif key == "f11" then
        love.window.setFullscreen(not love.window.getFullscreen(), "exclusive")
    end
end

function love.keyreleased(...)
    screenManager:emit("handleKeyRelease", ...)
end

function love.focus(isFocused)
    screenManager:emit("handleWindowFocus", isFocused)
end

function love.joystickadded(joystick)
    joystickManager.add(joystick)
end

function love.joystickremoved(joystick)
    joystickManager.remove(joystick)
end