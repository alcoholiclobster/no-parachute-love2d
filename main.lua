local Engine = require("engine.Engine")

local game

function love.load()
    game = Engine:new()
end

function love.update(deltaTime)
    game:update(deltaTime)
end

function love.draw()
    game:draw()
end