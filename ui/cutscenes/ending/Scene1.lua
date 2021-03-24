local class = require("lib.middleclass")
local BaseScene = require("ui.cutscenes.BaseScene")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")
local musicManager = require("utils.musicManager")

local Scene1 = class("Scene1", BaseScene)

function Scene1:initialize(cutscene)
    BaseScene.initialize(self, cutscene)

    local this = self
    self.thread = scheduler.createThread(function () this:process() end)

    musicManager:stop()
end

function Scene1:onHide()
    scheduler.killThread(self.thread)
end

function Scene1:process()
    scheduler.wait(3)

    self.cutscene:stop()
end

function Scene1:update(deltaTime)
end

function Scene1:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 0, 0, 128, 128)
end

return Scene1