local class = require("lib.middleclass")
local assets = require("core.assets")
local mathUtils = require("utils.math")

local Tutorial = class("Tutorial")

function Tutorial:initialize()
    self.time = 0

    self.showPart1 = 3
    self.hidePart1 = 8

    self.showPart2 = 11
    self.hidePart2 = 16

    self.showPart3 = 22
    self.hidePart3 = 27
end

function Tutorial:update(deltaTime)
    self.time = self.time + deltaTime
end

function Tutorial:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    if self.time > self.showPart1 and self.time < self.hidePart1 then
        local p = mathUtils.clamp01((self.time - self.showPart1) / 0.3)
        love.graphics.setColor(1, 1, 1, p)
        love.graphics.setFont(assets.font("Roboto-Bold", 44))
        love.graphics.printf("Use WASD or ARROWS to move", 0, screenHeight * 0.15, screenWidth, "center")
    end

    if self.time > self.showPart2 and self.time < self.hidePart2 then
        local p = mathUtils.clamp01((self.time - self.showPart2) / 0.3)
        love.graphics.setColor(1, 1, 1, p)
        love.graphics.setFont(assets.font("Roboto-Bold", 44))
        love.graphics.printf("Hold SPACE to increase speed", 0, screenHeight * 0.15, screenWidth, "center")

        love.graphics.setFont(assets.font("Roboto-Bold", 24))
        love.graphics.printf("and to earn more score points", 0, screenHeight * 0.15 + 50, screenWidth, "center")
    end

    if self.time > self.showPart3 and self.time < self.hidePart3 then
        local p = mathUtils.clamp01((self.time - self.showPart3) / 0.3)
        love.graphics.setColor(1, 1, 1, p)
        love.graphics.setFont(assets.font("Roboto-Bold", 48))
        love.graphics.printf("Avoid obstacles to survive", 0, screenHeight * 0.15, screenWidth, "center")
    end
end

return Tutorial