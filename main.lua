local argparse = require("lib.argparse")
local ScreenManager = require("ui.ScreenManager")
local GameScreen = require("ui.screens.GameScreen")
local joystickManager = require("utils.joystickManager")
local console = require("utils.console")
local gameConfig = require("config.game")
local mouseUtils = require("utils.mouse")

GLOBAL_DEBUG_ENABLED = false

local debugSimulateFrameRate = 30
local debugUpdateDelay = 0

local screenManager

function love.load(arg)
    console.log("love.load()")

    love.filesystem.setIdentity("no_parachute")

    local parser = argparse()
    parser:flag("--debug", "Run game in debug mode")
    parser:option("--level", "Force load game level")
    parser:option("--fps", "Simulate frame rate")
    parser:flag("--fullscreen", "Force fullscreen mode")
    local args = parser:parse(arg)

    GLOBAL_DEBUG_ENABLED = args.debug
    math.randomseed(os.time())

    debugSimulateFrameRate = tonumber(args.fps) or 0

    screenManager = ScreenManager:new()
    screenManager:show(require("ui.screens.MainMenuScreen")())

    if args.level then
        print("Force loading level "..tostring(args.level))
        screenManager:show(GameScreen:new(args.level))
    end

    if args.fullscreen then
        love.window.setFullscreen(true)
    end
end

function love.update(deltaTime)
    mouseUtils.update()

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

    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.printf(gameConfig.versionName, 0, love.graphics.getHeight() - 20, love.graphics.getWidth() - 10, "right")

    console.draw()
end

function love.keypressed(key, ...)
    screenManager:emit("handleKeyPress", key, ...)

    if key == "`" and GLOBAL_DEBUG_ENABLED then
        console.toggle()
    end
end

function love.keyreleased(...)
    screenManager:emit("handleKeyRelease", ...)
end

function love.joystickadded(joystick)
    joystickManager.add(joystick)
end

function love.joystickremoved(joystick)
    joystickManager.remove(joystick)
end