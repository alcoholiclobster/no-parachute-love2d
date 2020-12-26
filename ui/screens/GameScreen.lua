local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local GameManager = require("core.GameManager")
local buttons = require("ui.controls.buttons")
local assets = require("core.assets")
local SpeedEffect = require("ui.effects.SpeedEffect")
local Tutorial = require("ui.Tutorial")
local settings = require("core.settings")

local GameScreen = class("GameScreen", Screen)

function GameScreen:initialize(levelName)
    assert(type(levelName) == "string", "Level not specified")
    self.levelConfig = require("config.levels."..levelName)
    self.levelName = levelName
    self.gameManager = GameManager:new(self.levelConfig, self)

    self.levelProgress = 0
    self.playerScore = 0
    self.playerSpeed = 0
    self.state = "game"

    self.speedEffect = SpeedEffect:new()
    if self.levelConfig.enableTutorial then
        self.tutorial = Tutorial:new()
    end
end

function GameScreen:onShow()

end

function GameScreen:onHide()
    if self.tutorial then
        self.tutorial:destroy()
    end
end

function GameScreen:setSpeedEffectAmount(amount)
    self.speedEffect:setAmount(amount)
end

function GameScreen:restartLevel()
    self.screenManager:transition("GameScreen", self.levelName)
end

function GameScreen:draw()
    self.gameManager:draw()

    if love.keyboard.isDown("o") then
        return
    end

    if self.tutorial then
        self.tutorial:draw()
    end

    love.graphics.setColor(1, 1, 1, 1)
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    if self.state == "game" then
        if settings.get("speed_lines") then
            self.speedEffect:draw()
        end

        local progress = tostring(math.floor(self.levelProgress * 100)).."%"

        love.graphics.setColor(1, 1, 1, 0.75)
        love.graphics.setFont(assets.font("Roboto-Bold", 32))
        love.graphics.printf(progress, 0, screenHeight - 90, screenWidth, "center")
        love.graphics.setFont(assets.font("Roboto-Bold", 14))
        love.graphics.printf("PROGRESS", 0, screenHeight - 50, screenWidth, "center")

        local score = tostring(math.ceil(self.playerScore))
        love.graphics.setFont(assets.font("Roboto-Bold", 14))
        love.graphics.printf("SCORE", 0, 20, screenWidth, "center")
        love.graphics.setFont(assets.font("Roboto-Bold", 24))
        love.graphics.printf(score, 0, 40, screenWidth, "center")

        local speed = tostring(self.playerSpeed).." kph"
        love.graphics.setFont(assets.font("Roboto-Bold", 32))
        love.graphics.printf(speed, 0, screenHeight - 90, screenWidth - 20, "right")
        love.graphics.setFont(assets.font("Roboto-Bold", 14))
        love.graphics.printf("SPEED", 0, screenHeight - 50, screenWidth - 20, "right")

    elseif self.state == "dead" then
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

        local progress = tostring(math.floor(self.levelProgress * 100))

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(assets.font("Roboto-Bold", 48))
        love.graphics.printf("YOU DIED", 0, screenHeight * 0.3, screenWidth, "center")

        love.graphics.setFont(assets.font("Roboto-Bold", 14))
        love.graphics.printf("Progress: "..progress.."%", 0, screenHeight * 0.3 + 70, screenWidth, "center")

        local score = tostring(math.ceil(self.playerScore))

        love.graphics.printf("Score: "..score, 0, screenHeight * 0.3 + 100, screenWidth, "center")

        local buttonWidth, buttonHeight = 200, 50
        local buttonX, buttonY = (screenWidth - buttonWidth) * 0.5, screenHeight * 0.7
        if buttons.drawButton("Restart", buttonX, buttonY, buttonWidth, buttonHeight) then
            self:restartLevel()
        end
        buttonY = buttonY + buttonHeight + 10
        if buttons.drawButton("Exit to menu", buttonX, buttonY, buttonWidth, buttonHeight) then
            self.screenManager:transition("MainMenuScreen")
        end
    elseif self.state == "pause" then
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(assets.font("Roboto-Bold", 48))
        love.graphics.printf("PAUSED", 0, screenHeight * 0.3, screenWidth, "center")

        love.graphics.setFont(assets.font("Roboto-Bold", 16))
        love.graphics.printf("Press ESC to continue", 0, screenHeight * 0.3 + 55, screenWidth, "center")

        local buttonWidth, buttonHeight = 200, 50
        local buttonX, buttonY = (screenWidth - buttonWidth) * 0.5, screenHeight * 0.5
        if buttons.drawButton("Continue", buttonX, buttonY, buttonWidth, buttonHeight) then
            self.state = "game"
        end
        buttonY = buttonY + buttonHeight + 10
        if buttons.drawButton("Restart", buttonX, buttonY, buttonWidth, buttonHeight) then
            self:restartLevel()
        end
        buttonY = buttonY + buttonHeight + 10
        if buttons.drawButton("Exit to menu", buttonX, buttonY, buttonWidth, buttonHeight) then
            self.screenManager:transition("MainMenuScreen")
        end
    elseif self.state == "finished" then
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("Level finished", 0, screenHeight * 0.3, screenWidth, "center")

        local score = tostring(math.ceil(self.playerScore))
        love.graphics.printf("Score: "..score, 0, screenHeight * 0.3 + 70, screenWidth, "center")

        local buttonWidth, buttonHeight = 200, 50
        local buttonX, buttonY = (screenWidth - buttonWidth) * 0.5, screenHeight * 0.7
        if self.levelConfig.nextLevel then
            if buttons.drawButton("Next level", buttonX, buttonY, buttonWidth, buttonHeight) then
                self.screenManager:transition("GameScreen", self.levelConfig.nextLevel)
            end
        end
        buttonY = buttonY + buttonHeight + 10
        if buttons.drawButton("Exit to menu", buttonX, buttonY, buttonWidth, buttonHeight) then
            self.screenManager:transition("MainMenuScreen")
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
    self.state = "dead"
end

function GameScreen:update(deltaTime)
    if self.state ~= "pause" then
        if love.keyboard.isDown("z") then
            deltaTime = deltaTime * 0.25
        elseif love.keyboard.isDown("x") then
            deltaTime = deltaTime * 4
        end

        self.gameManager:update(deltaTime)
        if settings.get("speed_lines") then
            self.speedEffect:update(deltaTime)
        end
    end
end

function GameScreen:handleKeyPress(key, ...)
    if key == "escape" then
        if self.state == "game" then
            self.state = "pause"
        elseif self.state == "pause" then
            self.state = "game"
        end
    else
        self.gameManager:handleKeyPress(key, ...)
    end
end

function GameScreen:handleKeyRelease(...)
    self.gameManager:handleKeyRelease(...)
end

return GameScreen