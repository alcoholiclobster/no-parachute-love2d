local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local buttons = require("ui.controls.buttons")
local GameScreen = require("ui.screens.GameScreen")
local GameManager = require("core.GameManager")
local assets = require("core.assets")

local MainMenuScreen = class("MainMenuScreen", Screen)

local howToPlayText = [[HOW TO PLAY:

Use WASD or arrow keys to control player.
Controller should probably work too (but not in menus).

Avoid walls and don't die.

Contact me:
Email: bredikhin.nikita@gmail.com
Twitter: @alcolobster
]]

function MainMenuScreen:initialize()
    self.gameManager = GameManager:new(require("config.levels.level1_2"), self)
    self.gameManager:initializeMenuMode()

    self.levelsList = {}

    local levelName = "level1_1"
    while levelName do
        local config = require("config.levels."..levelName)
        table.insert(self.levelsList, {
            text = config.name,
            level = levelName,
        })
        levelName = config.nextLevel
    end
end

function MainMenuScreen:onShow()

end

function MainMenuScreen:onHide()

end

function MainMenuScreen:update(deltaTime)
    self.gameManager:update(deltaTime)
end

function MainMenuScreen:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    love.graphics.clear(44/255, 27/255, 63/255, 1)
    self.gameManager:draw()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(assets.font("Roboto-Bold", 48))
    love.graphics.printf("No Parachute", 0, screenHeight * 0.2, screenWidth, "center", 0)

    love.graphics.setFont(assets.font("Roboto-Bold", 16))
    love.graphics.printf("DEVELOPMENT VERSION", 0, screenHeight * 0.2 + 60, screenWidth, "center", 0)

    love.graphics.setFont(assets.font("Roboto-Regular", 16))
    love.graphics.printf(howToPlayText, screenWidth * 0.1 + 250, screenHeight * 0.4, screenWidth, "left", 0)

    local buttonWidth, buttonHeight = 200, 50
    local buttonX, buttonY = screenWidth * 0.1, screenHeight * 0.4
    for _, listItem in ipairs(self.levelsList) do
        if buttons.drawButton(listItem.text, buttonX, buttonY, buttonWidth, buttonHeight) then
            self.screenManager:show(GameScreen:new(listItem.level))
        end
        buttonY = buttonY + buttonHeight + 10
    end

    if buttons.drawButton("Exit to desktop", buttonX, screenHeight - buttonHeight * 2, buttonWidth, buttonHeight) then
        love.event.quit(0)
    end
end

return MainMenuScreen