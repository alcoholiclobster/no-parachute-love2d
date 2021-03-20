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

    musicManager:play("intro")
    self.planeTexture = assets.texture("cutscenes/intro/plane")
end

function Scene1:onHide()
    scheduler.killThread(self.thread)
end

function Scene1:process()
    scheduler.wait(2)
    self.planeTexture = assets.texture("cutscenes/intro/plane3")
    scheduler.wait(1)
    self.planeTexture = assets.texture("cutscenes/intro/plane2")
    scheduler.wait(2)
    self.planeTexture = assets.texture("cutscenes/intro/plane")
    scheduler.wait(1)

    self.cutscene:changeScene("intro.Scene2")
end

function Scene1:update(deltaTime)
end

function Scene1:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(assets.texture("cutscenes/intro/sky_bg"), 0, 0)


    local px1 = (-love.timer.getTime() * 8) % 128
    love.graphics.draw(assets.texture("cutscenes/intro/mountains_bg"), px1, 0)
    love.graphics.draw(assets.texture("cutscenes/intro/mountains_bg"), px1-128, 0)

    local px2 = (-love.timer.getTime() * 32) % 128
    love.graphics.draw(assets.texture("cutscenes/intro/trees_bg"), px2, 0)
    love.graphics.draw(assets.texture("cutscenes/intro/trees_bg"), px2-128, 0)

    local planeX = math.cos(love.timer.getTime() * 1.5) * 3 + 3
    local planeY = math.sin(love.timer.getTime() * 4) * 2
    love.graphics.draw(self.planeTexture, planeX, planeY)
end

return Scene1