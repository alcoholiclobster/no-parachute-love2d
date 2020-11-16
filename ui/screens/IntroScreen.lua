local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local scheduler = require("utils.scheduler")
local assets = require("core.assets")

local IntroScreen = class("IntroScreen", Screen)

function IntroScreen:initialize(levelName)
    self.introThread = scheduler.createThread(function ()
        scheduler.wait(1)
        self.image = assets.texture("cutscenes/intro/1")
        scheduler.wait(4)
        self.image = assets.texture("cutscenes/intro/2")
        scheduler.wait(3)
        self.image = assets.texture("cutscenes/intro/3")
        scheduler.wait(2)
        self.image = assets.texture("cutscenes/intro/4")
        scheduler.wait(3)
        self.screenManager:transition("GameScreen", "level1_1")
    end)

    self.image = nil
end

function IntroScreen:draw()
    if self.image then
        love.graphics.setColor(1, 1, 1, 1)
        local width, height = love.graphics.getWidth(), love.graphics.getHeight()
        local imageWidth = height * 0.8
        local imageHeight = height * 0.8
        love.graphics.draw(self.image, width / 2 - imageWidth / 2, height / 2 - imageHeight / 2, 0, 1 / 128 * imageHeight)
    end
end

function IntroScreen:onHide()
    scheduler.killThread(self.introThread)
end

function IntroScreen:handleKeyPress(key, ...)
    if key == "escape" then
        self.screenManager:transition("MainMenuScreen")
    end
end

return IntroScreen