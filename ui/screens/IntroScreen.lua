local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local scheduler = require("utils.scheduler")
local IntroManager = require("ui.intro.IntroManager")

local IntroScreen = class("IntroScreen", Screen)

function IntroScreen:initialize(levelName)
    self.introManager = IntroManager:new()
    self.introManager.screen = self
end

function IntroScreen:draw()
    self.introManager:draw()
end

function IntroScreen:update(deltaTime)
    self.introManager:update(deltaTime)
end

function IntroScreen:onHide()
    self.introManager:changeScene()
end

function IntroScreen:handleKeyPress(key, ...)
    if key == "escape" then
        self.screenManager:transition("MainMenuScreen")
    end
end

function IntroScreen:startGame()
    self.screenManager:transition("GameScreen", "level1_1")
end

return IntroScreen