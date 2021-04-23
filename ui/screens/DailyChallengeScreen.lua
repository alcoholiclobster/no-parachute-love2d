local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local widgets = require("ui.widgets")
local GameManager = require("core.GameManager")
local lz = require("utils.language").localize
local Steam = require("luasteam")

local DailyChallengeScreen = class("DailyChallengeScreen", Screen)

local startDay = 18739

function DailyChallengeScreen:initialize()
    local secondsInDay = 60 * 60 * 24
    local dayNumber = math.floor(os.time() / secondsInDay)
    local secondsCurrentDay = os.time() - dayNumber * secondsInDay
    print(math.floor(secondsCurrentDay / (60 * 60)))

    local seed = dayNumber + 1337

    local endlessLevel = require("config.levels.endless")
    endlessLevel.randomize(seed)
    self.gameManager = GameManager:new(endlessLevel, self, true)

    self.entries = {}

    Steam.userStats.findOrCreateLeaderboard("daily_"..tostring(seed), "Descending", "Numeric", function (data)
        Steam.userStats.uploadLeaderboardScore(data.steamLeaderboard, "ForceUpdate", math.random(1, 10), "hihi", function (data)
            print("uploaded ", data.success, data.globalRankNew)
        end)

        Steam.userStats.downloadLeaderboardEntries(data.steamLeaderboard, "Global", 1, 10, function (items)
            for _, item in ipairs(items) do
                table.insert(self.entries, {
                    rank = item.globalRank,
                    name = Steam.friends.getFriendPersonaName(item.steamIDUser),
                    score = item.score,
                })
            end
        end)
    end)
end

function DailyChallengeScreen:update(deltaTime)
    self.gameManager:update(deltaTime)
end

function DailyChallengeScreen:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    self.gameManager:draw()

    local secondsInDay = 60 * 60 * 24
    local dayNumber = math.floor(os.time() / secondsInDay)
    local secondsLeft = secondsInDay - (os.time() - dayNumber * secondsInDay)
    local timeLeft = string.format("%.2d:%.2d:%.2d", secondsLeft/(60*60), secondsLeft/60%60, secondsLeft%60)
    love.graphics.setColor(1, 1, 1)
    widgets.label("Day: "..tostring(dayNumber - startDay)..". Time left: "..timeLeft, screenWidth * 0.1, screenHeight * 0.1, screenWidth * 0.8, screenHeight * 0.05, false, "left")

    local h = screenHeight * 0.04
    local y = screenHeight * 0.1 + screenHeight * 0.08
    for i, item in ipairs(self.entries) do
        widgets.label(item.rank..". "..item.name.." - "..item.score, screenWidth * 0.1, y, screenWidth * 0.8, h, false, "left")
        y = y + h * 1.5
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

return DailyChallengeScreen