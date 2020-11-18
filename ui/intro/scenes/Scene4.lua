local class = require("lib.middleclass")
local IntroScene = require("ui.intro.IntroScene")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")

local Scene4 = class("Scene4", IntroScene)

function Scene4:initialize()
    local this = self
    self.thread = scheduler.createThread(function () this:process() end)

    self.line = 0
    self.characterProgress = 0

    self.treesProgress = 0
    self.treesMoving = false

    self.fadeProgress = 0
    self.isFading = false
end

function Scene4:onHide()
    scheduler.killThread(self.thread)
end

function Scene4:process()
    scheduler.wait(2)

    self.line = 1
    scheduler.wait(3)

    self.line = 2
    scheduler.wait(4)

    self.line = 0
    scheduler.wait(2)

    self.line = 3
    scheduler.wait(4)
    self.line = 0
    scheduler.wait(2)
    self.line = 4
    scheduler.wait(2)
    self.treesMoving = true
    scheduler.wait(3)
    self.line = 0
    scheduler.wait(2)
    self.fadeProgress = 0
    self.isFading = true
end

function Scene4:update(deltaTime)
    if self.characterProgress < 1 then
        self.characterProgress = self.characterProgress + deltaTime
        if self.characterProgress > 1 then
            self.characterProgress = 1
        end
    end

    if self.treesMoving then
        self.treesProgress = self.treesProgress + deltaTime / 6
        if self.treesProgress > 1 then
            self.treesProgress = 1
            self.treesMoving = false
        end
    end

    if self.isFading then
        self.fadeProgress = self.fadeProgress + deltaTime / 0.5
        if self.fadeProgress > 1 then
            self.fadeProgress = 1
            self.isFading = false
        end
    end
end

function Scene4:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(assets.texture("cutscenes/intro/sky_bg"), 0, 0)

    local treesY = 32 - self.treesProgress * 32
    local px1 = (-love.timer.getTime() * 2) % 128
    love.graphics.draw(assets.texture("cutscenes/intro/mountains_bg"), px1, treesY)
    love.graphics.draw(assets.texture("cutscenes/intro/mountains_bg"), px1-128, treesY)

    local px2 = (-love.timer.getTime() * 4) % 128
    love.graphics.draw(assets.texture("cutscenes/intro/trees_bg"), px2, treesY)
    love.graphics.draw(assets.texture("cutscenes/intro/trees_bg"), px2-128, treesY)

    local characterX = math.cos(love.timer.getTime() * 1.5) * 3 + 6
    local characterY = math.sin(love.timer.getTime() * 4) * 2 - 64 * math.pow(1 - self.characterProgress, 2)
    love.graphics.draw(assets.texture("cutscenes/intro/scene3_character"), characterX, characterY)

    if self.line == 1 then
        love.graphics.draw(assets.texture("cutscenes/intro/scene4_line1"), characterX, characterY)
    end

    if self.line == 2 then
        love.graphics.draw(assets.texture("cutscenes/intro/scene4_line2"), characterX - 7, characterY - 4)
    end

    if self.line == 3 then
        love.graphics.draw(assets.texture("cutscenes/intro/scene4_line3"), 0, math.sin(love.timer.getTime() * 2))
    end

    if self.line == 4 then
        love.graphics.draw(assets.texture("cutscenes/intro/scene4_line4"), 0, math.sin(love.timer.getTime() * 2))
    end

    if self.fadeProgress > 0 then
        love.graphics.setColor(0, 0, 0, self.fadeProgress)
        love.graphics.rectangle("fill", 0, 0, self.width, self.height)
    end
end

return Scene4