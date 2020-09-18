local GameManager = require("engine.GameManager")

local game

function love.load()
    game = GameManager:new(require("config.levels.level1"))
end

function love.update(deltaTime)
    game:update(deltaTime)
end

function love.draw()
    game:draw()
end

function love.keypressed(...)
    game:handleKeyPress(...)
end

function love.keyreleased(...)
    game:handleKeyRelease(...)
end