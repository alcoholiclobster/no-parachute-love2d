local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local buttons = require("ui.controls.buttons")
local GameScreen = require("ui.screens.GameScreen")

local MainMenuScreen = class("MainMenuScreen", Screen)

function MainMenuScreen:initialize()

end

function MainMenuScreen:onShow()

end

function MainMenuScreen:onHide()

end

function MainMenuScreen:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("No Parachute", 0, screenHeight * 0.25, screenWidth, "center", 0)

    local buttonWidth, buttonHeight = 200, 50
    local buttonX, buttonY = (screenWidth - buttonWidth) * 0.5, screenHeight * 0.4
    for i = 1, 3 do
        if buttons.drawButton("Level "..i, buttonX, buttonY, buttonWidth, buttonHeight) then
            self.screenManager:show(GameScreen:new(i))
        end
        buttonY = buttonY + buttonHeight + 10
    end
end

return MainMenuScreen