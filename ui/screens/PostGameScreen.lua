local class = require("lib.middleclass")
local Screen = require("ui.Screen")

local PostGameScreen = class("PostGameScreen", Screen)

function PostGameScreen:initialize(levelName)
    assert(type(levelName) == "string", "Level not specified")
    self.levelName = levelName
    self.levelConfig = require("config.levels."..levelName)

    self.cutscene = nil
end

function PostGameScreen:onShow()
    if self.levelConfig.finishCutscene then
        local cutsceneClass = require("ui.cutscenes."..self.levelConfig.finishCutscene)
        self.cutscene = cutsceneClass:new(self)
    end
end

function PostGameScreen:draw()
    if self.cutscene then
        self.cutscene:draw()
    end
end

function PostGameScreen:update(deltaTime)
    if self.cutscene then
        self.cutscene:update(deltaTime)
    end
end

function PostGameScreen:onHide()
    if self.cutscene then
        self.cutscene:onHide()
    end
end

function PostGameScreen:handleCutsceneFinish()
    self.screenManager:transition("CreditsScreen")
end

function PostGameScreen:handleKeyPress(key, ...)
    if self.cutscene then
        if key == "return" then
            self.screenManager:transition("MainMenuScreen")
        end
    end
end

return PostGameScreen