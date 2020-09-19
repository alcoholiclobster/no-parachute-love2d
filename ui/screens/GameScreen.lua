local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local GameManager = require("engine.GameManager")

local GameScreen = class("GameScreen", Screen)

function GameScreen:initialize(level)
    assert(type(level) == "number", "Level not specified")

    self.gameManager = GameManager:new(require("config.levels.level1"))
end

function GameScreen:onShow()

end

function GameScreen:onHide()

end

function GameScreen:draw()
    self.gameManager:draw()
end

function GameScreen:update(deltaTime)
    self.gameManager:update(deltaTime)
end

function GameScreen:handleKeyPress(...)
    self.gameManager:handleKeyPress(...)
end

function GameScreen:handleKeyRelease(...)
    self.gameManager:handleKeyRelease(...)
end

return GameScreen