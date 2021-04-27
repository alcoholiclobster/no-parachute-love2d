local assets = require("core.assets")
local widgets = require("ui.widgets")
local class = require("lib.middleclass")
local GameManager = require("core.GameManager")
local musicManager = require("utils.musicManager")
local Screen = require("ui.Screen")
local settings = require("utils.settings")
local SpeedEffect = require("ui.effects.SpeedEffect")
local mathUtils = require("utils.math")
local lz = require("utils.language").localize
local SettingsOverlay = require("ui.SettingsOverlay")
local rating = require("utils.rating")
local Steam = require("luasteam")

local GameScreen = class("GameScreen", Screen)

local playedCutscenes = {}

function GameScreen:initialize(levelName)
    assert(type(levelName) == "string", "Level not specified")
    self.levelConfig = require("config.levels."..levelName)
    self.levelName = levelName
    self.gameManager = GameManager:new(self.levelConfig, self)

    self.levelProgress = 0
    self.playerScore = 0
    self.playerSpeed = 0
    self:setState("game")
    self.isNewHighscore = false

    self.stateChangedAt = love.timer.getTime()

    self.speedEffect = SpeedEffect:new()
    self.settingsOverlay = nil

    self.currentText = nil
    self.currentTextShowTime = 0
    self.currentTextDuration = 0

    self.isWaitingForParachuteKey = false
    self.isHudEnabled = true

    if self.levelConfig.disableHud then
        self.isHudEnabled = false
    end

    self.globalRank = 0
end

function GameScreen:onShow()

end

function GameScreen:onHide()
    self.gameManager:destroy()
    love.mouse.setVisible(true)
end

function GameScreen:setSpeedEffectAmount(amount)
    self.speedEffect:setAmount(amount)
end

function GameScreen:restartLevel()
    self.screenManager:transition("GameScreen", self.levelName)
end

function GameScreen:exitToMenu()
    if self.levelName == "endless" then
        self.screenManager:transition("MainMenuScreen")
    else
        self.screenManager:transition("LevelSelectionScreen")
    end
end

function GameScreen:setState(newState)
    self.state = newState
    self.stateChangedAt = love.timer.getTime()

    if self.state == "game" then
        love.mouse.setVisible(false)
    else
        love.mouse.setVisible(true)
    end

    self.gameManager:handlePause(self.state == "pause")
end

function GameScreen:draw()
    self.gameManager:draw()

    if GameEnv.disableHud then
        return
    end

    love.graphics.setColor(1, 1, 1, 1)
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    if self.state == "game" then
        if settings.get("speed_lines") then
            self.speedEffect:draw()
        end

        if self.isHudEnabled then
            local progress = tostring(math.floor(self.levelProgress * 100)).."%"

            love.graphics.setColor(1, 1, 1, 0.75)
            love.graphics.setFont(assets.font("Roboto-Bold", 32))
            love.graphics.printf(progress, 0, screenHeight - 90, screenWidth, "center")
            love.graphics.setFont(assets.font("Roboto-Bold", 14))
            love.graphics.printf(lz("lbl_hud_progress"), 0, screenHeight - 50, screenWidth, "center")

            local score = tostring(math.ceil(self.playerScore))
            love.graphics.setFont(assets.font("Roboto-Bold", 14))
            love.graphics.printf(lz("lbl_hud_score"), 0, 20, screenWidth, "center")
            love.graphics.setFont(assets.font("Roboto-Bold", 24))
            love.graphics.printf(score, 0, 40, screenWidth, "center")

            local speed = tostring(self.playerSpeed).." "..lz("lbl_hud_speed_units")
            love.graphics.setFont(assets.font("Roboto-Bold", 32))
            love.graphics.printf(speed, 0, screenHeight - 90, screenWidth - 20, "right")
            love.graphics.setFont(assets.font("Roboto-Bold", 14))
            love.graphics.printf(lz("lbl_hud_speed"), 0, screenHeight - 50, screenWidth - 20, "right")
        end
        if self.currentText then
            local alpha = 1
            if self.currentTextTime < 0.5 then
                alpha = self.currentTextTime / 0.5
            elseif self.currentTextTime > self.currentTextDuration - 1 then
                alpha = self.currentTextDuration - self.currentTextTime
            end
            love.graphics.setColor(1, 1, 1, alpha)
            widgets.label(self.currentText, screenWidth * 0.2, screenHeight * 0.15, screenWidth * 0.6, screenHeight * 0.05, true, "center")
        end
    elseif self.state == "dead" then
        local stateTime = love.timer.getTime() - self.stateChangedAt

        love.graphics.setColor(0, 0, 0, 0.6 * mathUtils.clamp01(stateTime * 4))
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

        local progress = tostring(math.floor(self.levelProgress * 100))

        -- Labels
        love.graphics.setColor(178/255, 30/255, 32/255, math.min(1, stateTime * 2))
        local labelX, labelY = 0, screenHeight * 0.2
        local labelWidth, labelHeight = screenWidth, screenHeight * 0.12
        widgets.label(lz("lbl_game_you_died"), labelX, labelY, labelWidth, labelHeight, true, "center")

        love.graphics.setColor(0.75, 0.75, 0.75, math.min(1, stateTime * 2))
        labelY = labelY + labelHeight + screenHeight * 0.04
        labelHeight = screenHeight * 0.025
        if self.levelName ~= "endless" then
            widgets.label(lz("lbl_game_stats_progress", progress), labelX, labelY, labelWidth, labelHeight, false, "center")
        end

        labelY = labelY + labelHeight + screenHeight * 0.04
        local score = tostring(math.ceil(self.playerScore))
        widgets.label(lz("lbl_game_stats_score", score), labelX, labelY, labelWidth, labelHeight, false, "center")

        if self.globalRank and self.globalRank > 0 then
            labelY = labelY + labelHeight + screenHeight * 0.04
            widgets.label("Global rank: "..tostring(self.globalRank), labelX, labelY, labelWidth, labelHeight, false, "center")
        end

        -- Buttons
        love.graphics.setColor(1, 1, 1, math.min(1, stateTime * 2))
        local buttonX, buttonY = screenWidth * 0.35, screenHeight * 0.65
        local buttonWidth, buttonHeight = screenWidth * 0.3, screenHeight * 0.04
        if widgets.button(lz("btn_game_restart_level"), buttonX, buttonY, buttonWidth, buttonHeight, false, "center") or love.keyboard.isDown('r') then
            self:restartLevel()
        end
        buttonY = buttonY + buttonHeight * 1.5
        if widgets.button(lz("btn_game_exit_to_menu"), buttonX, buttonY, buttonWidth, buttonHeight, false, "center") then
            self:exitToMenu()
        end
    elseif self.state == "pause" then
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

        -- Labels
        love.graphics.setColor(1, 1, 1, 1)
        local labelX, labelY = 0, screenHeight * 0.2
        local labelWidth, labelHeight = screenWidth, screenHeight * 0.12
        widgets.label(lz("lbl_game_paused"), labelX, labelY, labelWidth, labelHeight, false, "center")

        labelY = labelY + labelHeight + screenHeight * 0.01
        labelHeight = screenHeight * 0.025
        widgets.label(lz("lbl_game_paused_continue"), labelX, labelY, labelWidth, labelHeight, false, "center")

        -- Buttons
        local buttonX, buttonY = screenWidth * 0.35, labelY + labelHeight + screenHeight * 0.1
        local buttonWidth, buttonHeight = screenWidth * 0.3, screenHeight * 0.04
        if widgets.button(lz("btn_game_paused_continue"), buttonX, buttonY, buttonWidth, buttonHeight, self.settingsOverlay, "center")then
            self:setState("game")
        end
        buttonY = buttonY + buttonHeight * 1.5
        if widgets.button(lz("btn_game_restart_level"), buttonX, buttonY, buttonWidth, buttonHeight, self.settingsOverlay, "center") or (love.keyboard.isDown('r') and not self.settingsOverlay) then
            self:restartLevel()
        end
        buttonY = buttonY + buttonHeight * 1.5
        if widgets.button(lz("btn_settings"), buttonX, buttonY, buttonWidth, buttonHeight, self.settingsOverlay, "center") then
            self.settingsOverlay = SettingsOverlay:new()
        end
        buttonY = buttonY + buttonHeight * 1.5
        if widgets.button(lz("btn_game_exit_to_menu"), buttonX, buttonY, buttonWidth, buttonHeight, self.settingsOverlay, "center") then
            self:exitToMenu()
        end

        if self.settingsOverlay then
            self.settingsOverlay:draw()
            if self.settingsOverlay.isClosed then
                self.settingsOverlay = nil
            end
        end
    elseif self.state == "finished" then
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

        -- Labels
        love.graphics.setColor(130/255, 90/255, 150/255, 1)
        local labelX, labelY = 0, screenHeight * 0.2
        local labelWidth, labelHeight = screenWidth, screenHeight * 0.12
        widgets.label(lz("lbl_game_level_complete"), labelX, labelY, labelWidth, labelHeight, true, "center")

        love.graphics.setColor(1, 1, 1, 1)
        labelY = labelY + labelHeight + screenHeight * 0.04
        labelHeight = screenHeight * 0.025
        widgets.label(lz("lbl_game_stats_time", self.timePassed), labelX, labelY, labelWidth, labelHeight, false, "center")

        if self.isNewBestTime then
            labelY = labelY + labelHeight + screenHeight * 0.02
            love.graphics.setColor(1, 0.65, 0)
            widgets.label(lz("lbl_game_finish_new_best_time"), labelX, labelY, labelWidth, labelHeight * 0.8, false, "center")
        end

        love.graphics.setColor(1, 1, 1, 1)
        labelY = labelY + labelHeight + screenHeight * 0.04
        local score = tostring(math.ceil(self.playerScore))
        widgets.label(lz("lbl_game_stats_score", score), labelX, labelY, labelWidth, labelHeight, false, "center")

        labelY = labelY + labelHeight + screenHeight * 0.02
        love.graphics.setColor(1, 1, 1)
        local starX = screenWidth * 0.5 - labelHeight * 1.5
        local starHeight = labelHeight

        -- Calculate stars count
        local rating = rating.calculateLevelRating(self.levelConfig, self.playerScore)

        for i = 1, 3 do
            widgets.star(starX, labelY, starHeight, i <= rating, true)
            starX = starX + starHeight
        end

        if self.isNewHighscore then
            labelY = labelY + labelHeight + screenHeight * 0.02
            love.graphics.setColor(1, 0.65, 0)
            widgets.label(lz("lbl_game_finish_new_highscore"), labelX, labelY, labelWidth, labelHeight * 0.8, false, "center")
        end

        -- Buttons
        love.graphics.setColor(1, 1, 1, 1)
        local buttonX, buttonY = screenWidth * 0.35, screenHeight * 0.65
        local buttonWidth, buttonHeight = screenWidth * 0.3, screenHeight * 0.04
        if widgets.button(lz("btn_game_next_level"), buttonX, buttonY, buttonWidth, buttonHeight, not self.levelConfig.nextLevel, "center") or (love.keyboard.isDown('f') and self.levelConfig.nextLevel) then
            self.screenManager:transition("GameScreen", self.levelConfig.nextLevel)
        end
        buttonY = buttonY + buttonHeight * 1.5
        if widgets.button(lz("btn_game_restart_level"), buttonX, buttonY, buttonWidth, buttonHeight, self.settingsOverlay, "center") or (love.keyboard.isDown('r') and not self.settingsOverlay) then
            self:restartLevel()
        end
        buttonY = buttonY + buttonHeight * 1.5
        if widgets.button(lz("btn_game_exit_to_menu"), buttonX, buttonY, buttonWidth, buttonHeight, false, "center") then
            self:exitToMenu()
        end
    end
end

function GameScreen:updateLevelProgress(value)
    self.levelProgress = value
end

function GameScreen:updateScore(value)
    self.playerScore = value
end

function GameScreen:updateSpeed(value)
    self.playerSpeed = math.ceil(math.abs(value / 30 * 198))
end

function GameScreen:showDeathScreen()
    self:setState("dead")
    self.globalRank = 0
    if self.levelName == "endless" and GameEnv.endlessForceSeed then
        local score = tostring(math.ceil(self.playerScore))

        Steam.userStats.findOrCreateLeaderboard("daily_"..GameEnv.endlessForceSeed, "Descending", "Numeric", function (data)
            Steam.userStats.uploadLeaderboardScore(data.steamLeaderboard, "KeepBest", score, "hihi", function (data)
                print("Uploaded new score", score, data.globalRankNew)
                if data.success then
                    self.globalRank = data.globalRankNew
                end
            end)
        end)
    end
end

function GameScreen:showFinishedScreen(timePassed, highscore, isNewHighscore, isNewBestTime)
    if self.levelConfig.finishCutscene and not playedCutscenes[self.levelConfig.finishCutscene] then
        playedCutscenes[self.levelConfig.finishCutscene] = true
        self.screenManager:transition("PostGameScreen", self.levelName)
        return
    end
    self:setState("finished")
    self.timePassed = timePassed or 0

    local minutes = math.floor(self.timePassed / 60)
    local seconds = self.timePassed % 60
    self.timePassed = string.format("%02d:%02d", minutes, seconds)

    self.playerScore = highscore

    self.isNewHighscore = isNewHighscore
    self.isNewBestTime = isNewBestTime
end

function GameScreen:showText(text, duration)
    if type(text) == "string" then
        text = lz(text)
    else
        text = nil
    end
    if text == self.currentText then
        return
    end
    self.currentText = text
    self.currentTextTime = 0
    self.currentTextDuration = duration or 0
end

function GameScreen:showParachutePrompt()
    if self.isWaitingForParachuteKey then
        return
    end
    self:showText(lz("lbl_intro_parachute_prompt"), 999)
    self.isWaitingForParachuteKey = true
end

function GameScreen:hideText()
    if self.currentText then
        self.currentTextTime = math.max(self.currentTextTime, self.currentTextDuration - 1)
    end
end

function GameScreen:update(deltaTime)
    if self.state ~= "pause" then
        if GameEnv.enableDebugMode then
            if love.keyboard.isDown("z") then
                deltaTime = deltaTime * 0.25
            elseif love.keyboard.isDown("x") then
                deltaTime = deltaTime * 4
            end
        end

        self.gameManager:update(deltaTime)
        if settings.get("speed_lines") then
            self.speedEffect:update(deltaTime)
        end

        if self.currentText then
            self.currentTextTime = self.currentTextTime + deltaTime
            if self.currentTextTime > self.currentTextDuration then
                self.currentTextTime = self.currentTextDuration
                self.currentText = nil
            end
        end

        if self.isWaitingForParachuteKey and love.keyboard.isDown("f") then
            self.isWaitingForParachuteKey = false
            self:showText(lz("lbl_intro_parachute_missing"), 5)

            musicManager:stop()
        end
    end
end

function GameScreen:handleKeyPress(key, ...)
    if key == "escape" then
        if self.state == "game" then
            self:setState("pause")
            musicManager:setSilenced(true)
        elseif self.state == "pause" and not self.settingsOverlay then
            self:setState("game")
            musicManager:setSilenced(false)
        end
    elseif key == "r" then
        if self.state == "game" then
            self:restartLevel()
        end
    else
        self.gameManager:handleKeyPress(key, ...)
    end
end

function GameScreen:handleWindowFocus(isFocused)
    if not isFocused and self.state == "game" then
        self:setState("pause")
    end
end

function GameScreen:handleKeyRelease(...)
    self.gameManager:handleKeyRelease(...)
end

function GameScreen:handleWindowResize(...)
    self.gameManager:handleWindowResize(...)
end

return GameScreen