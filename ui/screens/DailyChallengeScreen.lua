local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local widgets = require("ui.widgets")
local GameManager = require("core.GameManager")
local lz = require("utils.language").localize
local LeaderboardView = require("ui.LeaderboardView")

local DailyChallengeScreen = class("DailyChallengeScreen", Screen)

local startDay = 18739

function DailyChallengeScreen:initialize()
    local secondsInDay = 60 * 60 * 24
    local dayNumber = math.floor(os.time() / secondsInDay)

    local previousDaySeed = (dayNumber - 1) + 1337
    self.seed = dayNumber + 1337

    GameEnv.endlessForceSeed = self.seed
    local endlessLevel = require("config.levels.endless")
    self.gameManager = GameManager:new(endlessLevel, self, true, self.seed)

    self.globalLeaderboard = LeaderboardView:new({
        name = "daily_"..tostring(self.seed),
        type = "Global",
        title = lz("lbl_endless_lb_today_global"),
        limit = 15,
    })
    self.globalLeaderboard.x = 0.05
    self.globalLeaderboard.y = 0.2
    self.globalLeaderboard.width = 0.25
    self.globalLeaderboard.height = 0.6

    self.friendsLeaderboard = LeaderboardView:new({
        name = "daily_"..tostring(self.seed),
        type = "Friends",
        title = lz("lbl_endless_lb_today_friends"),
        limit = 15,
    })
    self.friendsLeaderboard.x = self.globalLeaderboard.x + self.globalLeaderboard.width + 0.05
    self.friendsLeaderboard.y = 0.2
    self.friendsLeaderboard.width = 0.25
    self.friendsLeaderboard.height = 0.6

    self.yesterdayLeaderboard = LeaderboardView:new({
        name = "daily_"..tostring(previousDaySeed),
        type = "Global",
        title = lz("lbl_endless_lb_yesterday_global"),
        limit = 20,
    })
    self.yesterdayLeaderboard.x = self.friendsLeaderboard.x + self.friendsLeaderboard.width + 0.05
    self.yesterdayLeaderboard.y = 0.2
    self.yesterdayLeaderboard.width = 0.25
    self.yesterdayLeaderboard.height = 0.6

    self.isReloading = false
end

function DailyChallengeScreen:update(deltaTime)
    self.gameManager:update(deltaTime)
end

function DailyChallengeScreen:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    self.gameManager:draw()

    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

    local secondsInDay = 60 * 60 * 24
    local dayNumber = math.floor(os.time() / secondsInDay)
    local secondsLeft = secondsInDay - (os.time() - dayNumber * secondsInDay)
    if secondsLeft <= 0 and not self.isReloading then
        secondsLeft = 0
        self.isReloading = true
        self.screenManager:transition("DailyChallengeScreen")
    end
    local timeLeft = string.format("%.2d:%.2d:%.2d", secondsLeft/(60*60), secondsLeft/60%60, secondsLeft%60)
    love.graphics.setColor(1, 1, 1)
    widgets.label(lz("lbl_endless_day_ends", timeLeft), screenWidth * 0.05, screenHeight * 0.07, screenWidth * 0.8, screenHeight * 0.05, false, "left")

    self.globalLeaderboard:draw()
    self.friendsLeaderboard:draw()
    self.yesterdayLeaderboard:draw()

    -- Back to menu screen button
    if widgets.button(lz("btn_back"), screenWidth * 0.08, screenHeight - screenHeight * 0.1, screenWidth * 0.2, screenHeight * 0.05) then
        self.screenManager:transition("MainMenuScreen")
    end
    -- Play button
    if widgets.button(lz("lbl_endless_start_challenge"), screenWidth * (0.5 - 0.2), screenHeight - screenHeight * 0.12, screenWidth * 0.4, screenHeight * 0.08, false, "center") then
        self.screenManager:transition("GameScreen", "endless")
    end
end

return DailyChallengeScreen