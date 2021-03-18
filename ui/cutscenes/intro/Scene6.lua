local class = require("lib.middleclass")
local BaseScene = require("ui.cutscenes.BaseScene")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")

local Scene4 = class("Scene4", BaseScene)

function Scene4:initialize()
    local this = self
    self.thread = scheduler.createThread(function () this:process() end)

    self.logoState = 0
end

function Scene4:onHide()
    scheduler.killThread(self.thread)
end

function Scene4:process()
    scheduler.wait(0.75)
    self.logoState = 1
    scheduler.wait(0.75)
    self.logoState = 2
    scheduler.wait(1.5)
    self.logoState = 0
    scheduler.wait(0.75)
    self.introManager:startGame()
end

function Scene4:update(deltaTime)

end

function Scene4:draw()
    love.graphics.clear(0, 0, 0, 1)
    love.graphics.setColor(1, 1, 1)
    if self.logoState > 0 then
        love.graphics.draw(assets.texture("cutscenes/intro/scene6_logo"), 0, 0)
    end
    if self.logoState > 1 then
        love.graphics.draw(assets.texture("cutscenes/intro/scene6_logo2"), 0, 0)
    end
end

return Scene4