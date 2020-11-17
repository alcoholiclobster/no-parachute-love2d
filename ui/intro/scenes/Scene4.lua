local class = require("lib.middleclass")
local IntroScene = require("ui.intro.IntroScene")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")

local Scene4 = class("Scene4", IntroScene)

function Scene4:initialize()
    local this = self
    self.thread = scheduler.createThread(function () this:process() end)

    self.characterProgress = 0
end

function Scene4:onHide()
    scheduler.killThread(self.thread)
end

function Scene4:process()
    -- scheduler.wait(3)
    -- -- Ok I think I'm ready
    -- self.line = self.line + 1
    -- scheduler.wait(4)

    -- -- DO IT
    -- self.line = self.line + 1
    -- scheduler.wait(3)

    -- self.introManager:changeScene("Scene2")
end

function Scene4:update(deltaTime)
    if self.characterProgress < 1 then
        self.characterProgress = self.characterProgress + deltaTime
        if self.characterProgress > 1 then
            self.characterProgress = 1
        end
    end
end

function Scene4:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(assets.texture("cutscenes/intro/sky_bg"), 0, 0)

    -- local px1 = (-love.timer.getTime() * 8) % 128
    -- love.graphics.draw(assets.texture("cutscenes/intro/mountains_bg"), px1, 0)
    -- love.graphics.draw(assets.texture("cutscenes/intro/mountains_bg"), px1-128, 0)

    -- local px2 = (-love.timer.getTime() * 32) % 128
    -- love.graphics.draw(assets.texture("cutscenes/intro/trees_bg"), px2, 0)
    -- love.graphics.draw(assets.texture("cutscenes/intro/trees_bg"), px2-128, 0)

    local characterX = math.cos(love.timer.getTime() * 1.5) * 3 + 6
    local characterY = math.sin(love.timer.getTime() * 4) * 2 - 64 * math.pow(1 - self.characterProgress, 2)
    love.graphics.draw(assets.texture("cutscenes/intro/scene3_character"), characterX, characterY)
end

return Scene4