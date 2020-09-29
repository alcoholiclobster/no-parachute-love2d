local argparse = require("lib.argparse")
local ScreenManager = require("ui.ScreenManager")
local GameScreen = require("ui.screens.GameScreen")
local joystickManager = require("utils.joystickManager")
local console = require("utils.console")

local isDebugEnabled = false
local screenManager

function love.load(arg)
    console.log("love.load()")

    local parser = argparse()
    parser:flag("-d --debug", "Run game in debug mode")
    parser:option("-l --level", "Force load game level")
    local args = parser:parse(arg)

    isDebugEnabled = args.debug
    math.randomseed(os.time())

    screenManager = ScreenManager:new()
    screenManager:show(require("ui.screens.MainMenuScreen"))

    if args.level then
        console.log("Force loading level "..tostring(args.level))
        screenManager:show(GameScreen:new(tonumber(args.level)))
    end
end

function love.update(deltaTime)
    screenManager:emit("update", deltaTime)
end

function love.draw()
    screenManager:emit("draw")

    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.printf("pre-alpha", 0, love.graphics.getHeight() - 20, love.graphics.getWidth() - 10, "right")

    console.draw()
end

function love.keypressed(key, ...)
    screenManager:emit("handleKeyPress", key, ...)

    if key == "`" and isDebugEnabled then
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