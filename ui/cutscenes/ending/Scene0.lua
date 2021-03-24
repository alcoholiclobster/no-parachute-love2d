local class = require("lib.middleclass")
local BaseScene = require("ui.cutscenes.BaseScene")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")

local Scene0 = class("Scene0", BaseScene)

function Scene0:initialize(cutscene)
    BaseScene.initialize(self, cutscene)

    local this = self
    self.thread = scheduler.createThread(function () this:process() end)
end

function Scene0:onHide()
    scheduler.killThread(self.thread)
end

function Scene0:process()
    scheduler.wait(2)

    self.cutscene:changeScene("ending.Scene1")
end

function Scene0:update(deltaTime)
end

function Scene0:draw()
    -- love.graphics.setColor(1, 1, 1)
    -- love.graphics.draw(assets.texture("cutscenes/intro/sky_bg"), 0, 0)
end

return Scene0