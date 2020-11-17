local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local scheduler = require("utils.scheduler")
local IntroManager = require("ui.intro.IntroManager")

local IntroScreen = class("IntroScreen", Screen)

function IntroScreen:initialize(levelName)
    -- self.introThread = scheduler.createThread(function ()
    --     scheduler.wait(1)
    --     self.image = assets.texture("cutscenes/intro/1")
    --     scheduler.wait(4)
    --     self.image = assets.texture("cutscenes/intro/2")
    --     scheduler.wait(3)
    --     self.image = assets.texture("cutscenes/intro/3")
    --     scheduler.wait(2)
    --     self.image = assets.texture("cutscenes/intro/4")
    --     scheduler.wait(3)
    --     self.screenManager:transition("GameScreen", "level1_1")
    -- end)

    -- self.image = nil
    self.introManager = IntroManager:new()
end

function IntroScreen:draw()
    self.introManager:draw()
end

function IntroScreen:onHide()
    self.introManager:changeScene()
end

function IntroScreen:handleKeyPress(key, ...)
    if key == "escape" then
        self.screenManager:transition("MainMenuScreen")
    end
end

return IntroScreen