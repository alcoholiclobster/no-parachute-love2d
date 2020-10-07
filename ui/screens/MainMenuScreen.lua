local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local buttons = require("ui.controls.buttons")
local GameScreen = require("ui.screens.GameScreen")
local assets = require("core.assets")

local MainMenuScreen = class("MainMenuScreen", Screen)

local howToPlayText = [[HOW TO PLAY:

Use WASD or arrow keys to control player.
Controller should probably work too (but not in menus).

Avoid walls and don't die.
]]

function MainMenuScreen:initialize()

end

function MainMenuScreen:onShow()

end

function MainMenuScreen:onHide()

end

function MainMenuScreen:draw()
    love.graphics.clear(44/255, 27/255, 63/255, 1)
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(assets.font("Roboto-Bold", 48))
    love.graphics.printf("No Parachute", 0, screenHeight * 0.2, screenWidth, "center", 0)

    love.graphics.setFont(assets.font("Roboto-Bold", 16))
    love.graphics.printf("VERY EARLY ALPHA", 0, screenHeight * 0.2 + 70, screenWidth, "center", 0)

    love.graphics.setFont(assets.font("Roboto-Regular", 16))
    love.graphics.printf(howToPlayText, screenWidth * 0.05, screenHeight * 0.4, screenWidth, "left", 0)

    local buttonWidth, buttonHeight = 200, 50
    local buttonX, buttonY = (screenWidth - buttonWidth) * 0.5, screenHeight * 0.4
    for i = 1, 3 do
        if buttons.drawButton("Level "..i, buttonX, buttonY, buttonWidth, buttonHeight) then
            self.screenManager:show(GameScreen:new(i))
        end
        buttonY = buttonY + buttonHeight + 10
    end

    if buttons.drawButton("Exit to desktop", buttonX, screenHeight - buttonHeight * 2, buttonWidth, buttonHeight) then
        love.event.quit(0)
    end
end

return MainMenuScreen