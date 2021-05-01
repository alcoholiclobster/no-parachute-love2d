local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local widgets = require("ui.widgets")
local GameManager = require("core.GameManager")
local lz = require("utils.language").localize
local assets = require("core.assets")
local storage = require("utils.storage")
local musicManager = require("utils.musicManager")
local LeaderboardView = require("ui.LeaderboardView")

local LevelSelectionScreen = class("LevelSelectionScreen", Screen)

local debugUnlockedLevels = {}
local lastSelectedLevelIndex = nil

function LevelSelectionScreen:initialize(selectLevelName)
    musicManager:play("menu_theme")

    self.levelsList = {}
    self.levelConfigs = {}

    local levelName = "intro"
    local levelIndex = 1
    local lastCompletedLevelIndex = 0

    self.earnedRating = 0
    self.totalRating = 0
    while levelName do
        local config = require("config.levels."..levelName)
        self.levelConfigs[levelName] = config
        local isCompleted = storage.getLevelData(levelName, "is_completed", false)
        local isUnlocked = levelIndex - 1 <= lastCompletedLevelIndex or debugUnlockedLevels[levelName] or GameEnv.unlockLevels
        local label = lz(config.name)
        -- Hide locked level name
        if not isUnlocked then
            label = label:gsub("%S", "?")
        end

        -- Load stats
        local stats = {
            { name = "highscore"},
            { name = "best_time"},
            { name = "deaths"},
            { name = "limbs_lost"},
        }
        for _, statsItem in ipairs(stats) do
            statsItem.label = "lbl_level_stats_"..statsItem.name
            statsItem.value = storage.getLevelData(levelName, statsItem.name, "-")

            if statsItem.name == "best_time" and type(statsItem.value) == "number" then
                local minutes = math.floor(statsItem.value / 60)
                local seconds = statsItem.value % 60
                local msec = math.floor((seconds - math.floor(seconds)) * 1000)
                statsItem.value = string.format("%02d:%02d:%03d", minutes, seconds, msec)
            end
        end

        -- Load rating
        local ratingItems = {0, 0, 0}
        if config.highscores then
            for i, value in ipairs(config.highscores) do
                ratingItems[i + 1] = value
            end
        end

        local rating = 0
        if isCompleted then
            local highscore = storage.getLevelData(levelName, "highscore", 0)

            for i = 1, 3 do
                if highscore >= ratingItems[i] then
                    rating = i
                end
            end
        end
        self.earnedRating = self.earnedRating + rating

        table.insert(self.levelsList, {
            isCompleted = isCompleted,
            isUnlocked = isUnlocked,
            label = label,
            name = levelName,
            config = config,
            stats = stats,
            rating = rating,
            ratingItems = ratingItems,
        })

        levelName = config.nextLevel
        if isCompleted then
            lastCompletedLevelIndex = levelIndex
        end
        levelIndex = levelIndex + 1
    end

    self.totalRating = #self.levelsList * 3

    self.selectedLevelIndex = math.min(#self.levelsList, lastCompletedLevelIndex + 1)
    if selectLevelName then
        for index, v in ipairs(self.levelsList) do
            if v.name == selectLevelName then
                self.selectedLevelIndex = index
            end
        end
    end
    if lastSelectedLevelIndex and lastSelectedLevelIndex <= lastCompletedLevelIndex then
        self.selectedLevelIndex = lastSelectedLevelIndex
    end

    self.backgroundFade = 0
    self.backgroundLevelTransitionTime = 0.25
    self.backgroundLevelName = self.levelsList[self.selectedLevelIndex].name
    self.nextBackgroundLevelName = nil
    self.gameManager = GameManager:new(self.levelConfigs[self.backgroundLevelName], self, true)

    self.arrowTexture = assets.texture("arrow", true)
    self.arrowTextureWidth = self.arrowTexture:getWidth()

    self:toggleLeaderboards()
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

    -- Selected level item
    local itemData = self.levelsList[self.selectedLevelIndex]
    if not itemData.isUnlocked then
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    end

    -- Selected level panel
    local panelWidth = math.max(screenWidth * 0.25, screenHeight * 0.5)
    local panelHeight = screenHeight * 0.6
    local panelX = screenWidth * 0.08
    local panelY = (screenHeight - panelHeight) / 2

    -- love.graphics.setColor(0, 0, 0, 0.9)
    -- love.graphics.rectangle("fill", panelX, panelY, panelWidth, panelHeight)

    local itemX, itemY = panelX, panelY
    local itemWidth, itemHeight = panelWidth, panelHeight * 0.1
    -- Level Name
    love.graphics.setColor(165/255, 86/255, 125/255)
    widgets.label(itemData.label, itemX, itemY, itemWidth, itemHeight, true, "center")

    love.graphics.setLineWidth(itemHeight * 0.04)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.line(itemX+2, itemY+2, itemX + itemWidth* 0.45+2, itemY+2)
    love.graphics.line(itemX+itemWidth*0.55+2, itemY+2, itemX + itemWidth+2, itemY+2)
    love.graphics.line(itemX+2, itemY + itemHeight * 1.4+2, itemX + itemWidth+2, itemY + itemHeight * 1.4+2)

    love.graphics.setColor(130/255, 90/255, 150/255, 1)
    love.graphics.line(itemX, itemY, itemX + itemWidth * 0.45, itemY)
    love.graphics.line(itemX+itemWidth*0.55, itemY, itemX + itemWidth, itemY)
    love.graphics.line(itemX, itemY + itemHeight * 1.4, itemX + itemWidth, itemY + itemHeight * 1.4)

    widgets.label(tostring(self.selectedLevelIndex), itemX+itemWidth*0.4, itemY-itemHeight*0.25, itemWidth*0.2, itemHeight*0.35, true, "center")

    itemY = itemY + itemHeight * 1.4 + panelHeight * 0.025
    itemHeight = panelHeight * 0.05
    for _, row in ipairs(itemData.stats) do
        love.graphics.setColor(0.75, 0.75, 0.75)
        widgets.label(lz(row.label), itemX, itemY, itemWidth, itemHeight, false, "left")
        love.graphics.setColor(1, 1, 1)
        widgets.label(row.value, itemX, itemY, itemWidth, itemHeight, true, "right")
        itemY = itemY + itemHeight + panelHeight * 0.025
    end

    -- Stars
    itemY = itemY + panelHeight * 0.055
    itemWidth = panelWidth / 3 - panelWidth * 0.05
    local highlightedRatingItem = nil
    for i = 1, 3 do
        if widgets.star(itemX, itemY, itemWidth, i <= itemData.rating) then
            highlightedRatingItem = i
        end
        itemX = itemX + itemWidth + panelWidth * 0.075
    end

    if highlightedRatingItem then
        itemWidth = panelWidth
        itemHeight = panelHeight * 0.05
        itemX = panelX + panelWidth * 1.05

        love.graphics.setColor(0.75, 0.75, 0.75)
        widgets.label(lz("lbl_level_stats_rating_requirements")..":", itemX, itemY, itemWidth, itemHeight, false, "left")
        itemY = itemY + itemHeight + screenHeight * 0.01

        love.graphics.setColor(1, 1, 1)
        local value = itemData.ratingItems[highlightedRatingItem]
        local label
        if value == 0 then
            label = lz("lbl_level_stats_rating_requirements_complete")
        else
            label = lz("lbl_level_stats_rating_requirements_score", value)
        end
        widgets.label(label, itemX, itemY, itemWidth, itemHeight, true, "left")
    end

    local btnWidth, btnHeight = panelWidth, screenHeight * 0.05
    local btnX, btnY = panelX + (panelWidth - btnWidth) / 2, panelY + panelHeight - btnHeight
    -- Panel buttons
    if widgets.button(lz("btn_back"), btnX, btnY, btnWidth, btnHeight, false, "center") then
        self.screenManager:transition("MainMenuScreen")
    end
    btnHeight = panelHeight * 0.12
    btnY = btnY - btnHeight
    love.graphics.setColor(165/255, 86/255, 125/255)
    local startGameButtonLabel = lz("btn_level_selection_start_game")
    if not itemData.isUnlocked then
        startGameButtonLabel = lz("btn_level_selection_level_locked")
    end
    if widgets.button(startGameButtonLabel, btnX, btnY, btnWidth, btnHeight, not itemData.isUnlocked, "center") then
        self:startLevel()
    end

    -- Arrows
    --Left
    local arrowSize = panelHeight * 0.08
    itemX, itemY = panelX, panelY + (panelHeight * 0.14 - arrowSize) / 2
    local arrowScale = arrowSize/self.arrowTextureWidth
    love.graphics.setColor(0, 0, 0)
    love.graphics.draw(self.arrowTexture, itemX+2, itemY+2, 0, -arrowScale, arrowScale)

    if widgets.button(" ", itemX - arrowSize, itemY, arrowSize, arrowSize, false, "right") then
        self:selectPreviousLevel()
    end
    love.graphics.draw(self.arrowTexture, itemX, itemY, 0, -arrowScale, arrowScale)

    -- Right
    love.graphics.setColor(0, 0, 0)
    love.graphics.draw(self.arrowTexture, itemX + panelWidth+2, itemY+2, 0, arrowScale, arrowScale)

    if widgets.button(" ", itemX + panelWidth, itemY, arrowSize, arrowSize, false, "left") then
        self:selectNextLevel()
    end
    love.graphics.draw(self.arrowTexture, itemX + panelWidth, itemY, 0, arrowScale, arrowScale)

    -- Rating
    local starSize = screenHeight * 0.04
    widgets.star(screenWidth * 0.905, screenHeight * 0.05+starSize*0.17, starSize, true, true)
    love.graphics.setColor(1, 1, 1)
    widgets.label(self.earnedRating.."/"..self.totalRating, screenWidth * 0.7, screenHeight * 0.05, screenWidth * 0.2, starSize, false, "right")

    -- Leaderboards
    if self.leaderboardView then
        self.leaderboardView:draw()
    end
end

function LevelSelectionScreen:startLevel()
    local selectedLevel = self.levelsList[self.selectedLevelIndex]
    if selectedLevel then
        self.screenManager:transition("PreGameScreen", selectedLevel.name)
    end
end

function LevelSelectionScreen:selectNextLevel()
    if self.selectedLevelIndex == #self.levelsList then
        return
    end
    self.selectedLevelIndex = self.selectedLevelIndex + 1
    lastSelectedLevelIndex = self.selectedLevelIndex
    if self.levelsList[self.selectedLevelIndex].isUnlocked then
        self:showBackgroundLevel(self.levelsList[self.selectedLevelIndex].name)
        self:reloadLeaderboards()
    end
end

function LevelSelectionScreen:selectPreviousLevel()
    if self.selectedLevelIndex == 1 then
        return
    end
    self.selectedLevelIndex = self.selectedLevelIndex - 1
    lastSelectedLevelIndex = self.selectedLevelIndex
    if self.levelsList[self.selectedLevelIndex].isUnlocked then
        self:showBackgroundLevel(self.levelsList[self.selectedLevelIndex].name)
        self:reloadLeaderboards()
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

function LevelSelectionScreen:handleWindowResize(...)
    self.gameManager:handleWindowResize(...)
end

function LevelSelectionScreen:handleKeyPress(key)
    if key == "escape" or key == "backspace" then
        self.screenManager:transition("MainMenuScreen")
    elseif key == "right" or key == "d" then
        self:selectNextLevel()
    elseif key == "left" or key == "a" then
        self:selectPreviousLevel()
    elseif key == "return" then
        self:startLevel()
    end
end

function LevelSelectionScreen:toggleLeaderboards()
    if not self.leaderboardView then
        local selectedLevel = self.levelsList[self.selectedLevelIndex]
        if not selectedLevel then
            return
        end
        self.leaderboardView = LeaderboardView:new({
            name = selectedLevel.name,
            type = "Friends",
            title = lz("lbl_leaderboard_friends"),
            limit = 15,
        })
        self.leaderboardView.x = 0.67
        self.leaderboardView.y = 0.2
        self.leaderboardView.width = 0.25
        self.leaderboardView.height = 0.6
    else
        self.leaderboardView = nil
    end
end

function LevelSelectionScreen:reloadLeaderboards()
    if self.leaderboardView then
        self:toggleLeaderboards()
        self:toggleLeaderboards()
    end
end

return LevelSelectionScreen