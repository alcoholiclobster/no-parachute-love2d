local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local widgets = require("ui.widgets")
local GameManager = require("core.GameManager")
local lz = require("utils.language").localize
local assets = require "core.assets"

local LevelSelectionScreen = class("LevelSelectionScreen", Screen)

function LevelSelectionScreen:initialize()
    self.levelsList = {}
    self.levelConfigs = {}

    local levelName = "intro"
    while levelName do
        local config = require("config.levels."..levelName)
        self.levelConfigs[levelName] = config
        table.insert(self.levelsList, {
            label = config.name,
            name = levelName,
            config = config,

            stats = {
                { name = "Highscore", value = "999 999 999"},
                { name = "Best Time", value = "00:30"},
                { name = "Deaths", value = "999"},
                { name = "Limbs lost", value = "999"},
            }
        })
        levelName = config.nextLevel
    end

    self.selectedLevelIndex = 4 -- TODO: Select last available level

    self.backgroundFade = 0
    self.backgroundLevelTransitionTime = 0.25
    self.backgroundLevelName = self.levelsList[self.selectedLevelIndex].name
    self.nextBackgroundLevelName = nil
    self.gameManager = GameManager:new(self.levelConfigs[self.backgroundLevelName], self, true)

    self.starTexture = assets.texture("star", true)
    self.arrowTexture = assets.texture("arrow", true)
    self.arrowTextureWidth = self.arrowTexture:getWidth()
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
    love.graphics.origin()
    if self.backgroundFade > 0 then
        love.graphics.setColor(0, 0, 0, self.backgroundFade)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    end

    -- Selected level panel
    local panelWidth = screenWidth * 0.25
    local panelHeight = screenHeight * 0.6
    local panelX = screenWidth * 0.08
    local panelY = (screenHeight - panelHeight) / 2

    -- love.graphics.setColor(0, 0, 0, 0.9)
    -- love.graphics.rectangle("fill", panelX, panelY, panelWidth, panelHeight)

    local itemX, itemY = panelX, panelY
    local itemWidth, itemHeight = panelWidth, panelHeight * 0.1
    -- Level Name
    local itemData = self.levelsList[self.selectedLevelIndex]
    love.graphics.setColor(1, 1, 1, 0.9)
    love.graphics.setColor(165/255, 86/255, 125/255)
    widgets.label(itemData.label, itemX, itemY, itemWidth, itemHeight, true, "center")

    love.graphics.setLineWidth(itemHeight * 0.05)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.line(itemX+2, itemY+2, itemX + itemWidth+2, itemY+2)
    love.graphics.line(itemX+2, itemY + itemHeight * 1.4+2, itemX + itemWidth+2, itemY + itemHeight * 1.4+2)

    love.graphics.setColor(130/255, 90/255, 150/255, 1)
    love.graphics.line(itemX, itemY, itemX + itemWidth, itemY)
    love.graphics.line(itemX, itemY + itemHeight * 1.4, itemX + itemWidth, itemY + itemHeight * 1.4)

    itemY = itemY + itemHeight * 1.4 + panelHeight * 0.025
    itemHeight = panelHeight * 0.05
    for _, row in ipairs(itemData.stats) do
        love.graphics.setColor(0.75, 0.75, 0.75)
        widgets.label(row.name, itemX, itemY, itemWidth, itemHeight, false, "left")
        love.graphics.setColor(1, 1, 1)
        -- love.graphics.setColor(165/255, 86/255, 125/255)
        widgets.label(row.value, itemX, itemY, itemWidth, itemHeight, true, "right")
        itemY = itemY + itemHeight + panelHeight * 0.025
    end

    itemY = itemY + panelHeight * 0.03
    itemWidth = panelWidth / 3 - panelWidth * 0.05
    for i = 1, 3 do
        local isActive = i <= 2
        if isActive then
            love.graphics.setColor(0, 0, 0, 0.9)
            love.graphics.draw(self.starTexture, itemX + 4, itemY + 2, 0, itemWidth/self.starTexture:getWidth())
            love.graphics.setColor(1, 0.7, 0)
        else
            love.graphics.setColor(0, 0, 0, 0.5)
        end
        love.graphics.draw(self.starTexture, itemX, itemY, 0, itemWidth/self.starTexture:getWidth())
        itemX = itemX + itemWidth + panelWidth * 0.075
    end
    local btnWidth, btnHeight = panelWidth, screenHeight * 0.05
    local btnX, btnY = panelX + (panelWidth - btnWidth) / 2, panelY + panelHeight - btnHeight
    -- Panel buttons
    if widgets.button(lz("btn_back"), btnX, btnY, btnWidth, btnHeight, false, "center") then
        self.screenManager:transition("MainMenuScreen")
    end
    btnHeight = screenHeight * 0.09
    btnY = btnY - btnHeight
    if widgets.button("START GAME", btnX, btnY, btnWidth, btnHeight, false, "center") then
        self.screenManager:transition("GameScreen", itemData.name)
    end

    -- Arrows
    local arrowSize = panelHeight * 0.14
    itemX, itemY = panelX, panelY
    local arrowScale = arrowSize/self.arrowTextureWidth
    if widgets.button(" ", itemX - arrowSize, itemY, arrowSize, arrowSize, false, "right") then
        self:selectPreviousLevel()
    end
    love.graphics.draw(self.arrowTexture, itemX, itemY, 0, -arrowScale, arrowScale)

    if widgets.button(" ", itemX + panelWidth, itemY, arrowSize, arrowSize, false, "left") then
        self:selectNextLevel()
    end
    love.graphics.draw(self.arrowTexture, itemX + panelWidth, itemY, 0, arrowScale, arrowScale)
end

function LevelSelectionScreen:selectNextLevel()
    if self.selectedLevelIndex == #self.levelsList then
        return
    end
    self.selectedLevelIndex = self.selectedLevelIndex + 1
    self:showBackgroundLevel(self.levelsList[self.selectedLevelIndex].name)
end

function LevelSelectionScreen:selectPreviousLevel()
    if self.selectedLevelIndex == 1 then
        return
    end
    self.selectedLevelIndex = self.selectedLevelIndex - 1
    self:showBackgroundLevel(self.levelsList[self.selectedLevelIndex].name)
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