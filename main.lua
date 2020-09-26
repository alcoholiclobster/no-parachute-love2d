local ScreenManager = require("ui.ScreenManager")

local screenManager

function love.load()
    math.randomseed(os.time())

    screenManager = ScreenManager:new()
    screenManager:show(require("ui.screens.MainMenuScreen"))
end

function love.update(deltaTime)
    screenManager:emit("update", deltaTime)
end

function love.draw()
    screenManager:emit("draw")

    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.printf("pre-alpha", 0, love.graphics.getHeight() - 20, love.graphics.getWidth() - 10, "right")
end

function love.keypressed(...)
    screenManager:emit("handleKeyPress", ...)
end

function love.keyreleased(...)
    screenManager:emit("handleKeyRelease", ...)
end