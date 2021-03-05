local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local widgets = require("ui.widgets")
local GameManager = require("core.GameManager")
local lz = require("utils.language").localize

local LevelSelectionScreen = class("LevelSelectionScreen", Screen)

function LevelSelectionScreen:initialize()
    self.levelsList = {}
    self.levelConfigs = {}

    local levelName = "intro"
    while levelName do
        local config = require("config.levels."..levelName)
        self.levelConfigs[levelName] = config
        table.insert(self.levelsList, {
            text = config.name,
            level = levelName,
        })
        levelName = config.nextLevel
    end

    self.backgroundFade = 0
    self.backgroundLevelTransitionTime = 0.25
    self.backgroundLevelName = "meat1" -- TODO: Select last available level
    self.nextBackgroundLevelName = nil
    self.gameManager = GameManager:new(self.levelConfigs[self.backgroundLevelName], self, true)
end

function LevelSelectionScreen:update(deltaTime)
    self.gameManager:update(deltaTime)

    if self.nextBackgroundLevelName then
        self.backgroundFade = self.backgroundFade + deltaTime / self.backgroundLevelTransitionTime
        if self.backgroundFade > 1 then
            self.backgroundFade = 1
            self.backgroundLevelName = self.nextBackgroundLevelName
            self.gameManager:destroy()
            self.gameManager = GameManager:new(self.levelConfigs[self.backgroundLevelName], self, true)
            self.nextBackgroundLevelName = nil
        end
    else
        self.backgroundFade = math.max(0, self.backgroundFade - deltaTime / self.backgroundLevelTransitionTime)
    end
end

function LevelSelectionScreen:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    self.gameManager:draw()
    if self.backgroundFade > 0 then
        love.graphics.setColor(0, 0, 0, self.backgroundFade)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    end

    local btnX, btnY = screenWidth * 0.08, screenHeight * 0.1
    local btnWidth, btnHeight = screenWidth * 0.5, screenHeight * 0.03
    local btnSpace = screenHeight * 0.01

    -- Level selection buttons
    for i, levelInfo in ipairs(self.levelsList) do
        local x = btnX
        if levelInfo.level == self.backgroundLevelName then
            if levelInfo.level == self.nextBackgroundLevelName then
                x = x + btnWidth * 0.02 * self.backgroundFade
            else
                x = x + btnWidth * 0.02 * (1-self.backgroundFade)
            end
        end
        if widgets.button(i..". "..levelInfo.text, x, btnY, btnWidth, btnHeight) then
            self:showBackgroundLevel(levelInfo.level)
        end
        btnY = btnY + btnHeight + btnSpace
    end

    -- Back to menu screen button
    if widgets.button(lz("btn_back"), screenWidth * 0.08, screenHeight - screenHeight * 0.1, screenWidth * (0.5 - 0.08 * 2), screenHeight * 0.05) then
        self.screenManager:transition("MainMenuScreen")
    end
    -- Play button
    if widgets.button(lz("btn_level_selection_start_game", self.backgroundLevelName), screenWidth * (0.7 - 0.04), screenHeight - screenHeight * 0.1, screenWidth * 0.3, screenHeight * 0.05, false, "right") then
        self.screenManager:transition("GameScreen", self.backgroundLevelName)
    end
end

function LevelSelectionScreen:showBackgroundLevel(levelName)
    if self.nextBackgroundLevelName == levelName or self.backgroundLevelName == levelName then
        return
    end

    local config = self.levelConfigs[levelName]
    if not config then
        return
    end

    self.nextBackgroundLevelName = levelName
end

return LevelSelectionScreen