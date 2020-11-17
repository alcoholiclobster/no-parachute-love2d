local class = require("lib.middleclass")
local IntroScene = require("ui.intro.IntroScene")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")

local Scene1 = class("Scene1", IntroScene)

function Scene1:initialize()
    local this = self
    self.thread = scheduler.createThread(function () this:process() end)

    self.line = 0
end

function Scene1:onHide()
    scheduler.killThread(self.thread)
end

function Scene1:process()
    scheduler.wait(3)
    -- Ok I think I'm ready
    self.line = self.line + 1
    scheduler.wait(4)

    -- DO IT
    self.line = self.line + 1
    scheduler.wait(3)

    self.introManager:changeScene("Scene2")
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
    love.graphics.draw(assets.texture("cutscenes/intro/plane"), planeX, planeY)

    if self.line == 1 then
        local popupx1 = math.cos(love.timer.getTime() * 1.5 - 1) * 3 + 3
        local popupy1 = math.sin(love.timer.getTime() * 4 - 1) * 2
        love.graphics.draw(assets.texture("cutscenes/intro/line1"), popupx1, popupy1)
    end

    if self.line == 2 then
        local popupx2 = math.cos(love.timer.getTime() * 1.5 - 1) * 3 + 3
        local popupy2 = math.sin(love.timer.getTime() * 4 - 2) * 1 + 2
        love.graphics.draw(assets.texture("cutscenes/intro/line2"), popupx2, popupy2)
    end
end

return Scene1