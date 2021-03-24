local class = require("lib.middleclass")
local BaseScene = require("ui.cutscenes.BaseScene")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")

local Scene1 = class("Scene1", BaseScene)

function Scene1:initialize(cutscene)
    BaseScene.initialize(self, cutscene)

    local this = self
    self.thread = scheduler.createThread(function () this:process() end)

    self.characterSpeedX = 0
    self.characterSpeedY = 0
    self.characterX = 64
    self.characterY = 128
end

function Scene1:onHide()
    scheduler.killThread(self.thread)
end

function Scene1:process()
    scheduler.wait(1)
    self.characterSpeedY = -70
    scheduler.wait(2.5)

    self.cutscene:changeScene("ending.Scene2")
end

function Scene1:update(deltaTime)
    self.characterSpeedY = self.characterSpeedY + 1 * deltaTime
    self.characterX = self.characterX + self.characterSpeedX * deltaTime
    self.characterY = self.characterY + self.characterSpeedY * deltaTime
end

function Scene1:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(assets.texture("cutscenes/ending/sky_bg"), 0, 0)

    local px1 = (-love.timer.getTime() * 8) % 128
    love.graphics.draw(assets.texture("cutscenes/ending/mountains_bg"), px1, 0)
    love.graphics.draw(assets.texture("cutscenes/ending/mountains_bg"), px1-128, 0)

    local rot = math.floor(love.timer.getTime() * 3 * 5) / 5
    love.graphics.draw(assets.texture("cutscenes/ending/character"), self.characterX, self.characterY, rot, 1, 1, 8, 8)

    local px2 = (-love.timer.getTime() * 32) % 128
    love.graphics.draw(assets.texture("cutscenes/ending/trees_bg"), px2, 0)
    love.graphics.draw(assets.texture("cutscenes/ending/trees_bg"), px2-128, 0)
end

return Scene1