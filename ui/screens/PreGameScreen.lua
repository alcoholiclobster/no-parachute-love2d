local class = require("lib.middleclass")
local Screen = require("ui.Screen")

local PreGameScreen = class("PreGameScreen", Screen)

function PreGameScreen:initialize(levelName)
    assert(type(levelName) == "string", "Level not specified")
    self.levelName = levelName
    self.levelConfig = require("config.levels."..levelName)

    self.cutscene = nil
end

function PreGameScreen:onShow()
    if self.levelConfig.cutscene then
        local cutsceneClass = require("ui.cutscenes."..self.levelConfig.cutscene)
        self.cutscene = cutsceneClass:new(self)
    end
end

function PreGameScreen:draw()
    if self.cutscene then
        self.cutscene:draw()
    end
end

function PreGameScreen:update(deltaTime)
    if self.cutscene then
        self.cutscene:update(deltaTime)
    end
end

function PreGameScreen:onHide()
    if self.cutscene then
        self.cutscene:changeScene()
    end
end

function PreGameScreen:handleKeyPress(key, ...)
    if self.cutscene and key == "escape" then
        self.screenManager:transition("MainMenuScreen")
    end
end

function PreGameScreen:startGame()
    self.screenManager:transition("GameScreen", self.levelName)
end

return PreGameScreen