local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local GameManager = require("core.GameManager")
local musicManager = require("utils.musicManager")
local widgets = require("ui.widgets")
local lz = require("utils.language").localize
local assets = require "core.assets"

local MainMenuScreen = class("MainMenuScreen", Screen)

function MainMenuScreen:initialize()
    -- musicManager:play("menu_theme")
    self.gameManager = GameManager:new(require("config.levels.deep_forest1"), self, true)

    self.buttons = {
        { label = "main_menu_btn_play_story", },
        { label = "main_menu_btn_play_daily_challenge", },
        { label = "main_menu_btn_play_endless_mode", },
        { label = "btn_settings", },
        { label = "btn_exit_game", },
    }

    self.highlightedButtonIndex = 1

    self.logoImage = assets.texture("logo")
end

function MainMenuScreen:update(deltaTime)
    self.gameManager:update(deltaTime)
end

function MainMenuScreen:draw()
    self.gameManager:draw()

    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    local btnX, btnY = screenWidth * 0.06, screenHeight * 0.5
    local btnWidth, btnHeight = screenWidth * 0.8, screenHeight * 0.04
    local btnSpace = screenHeight * 0.02
    for i, buttonData in ipairs(self.buttons) do
        widgets.button(lz(buttonData.label), btnX, btnY, btnWidth, btnHeight, self.highlightedButtonIndex == i)
        btnY = btnY + btnHeight + btnSpace
    end

    local logoScale = screenHeight * 0.00225
    local logoImageWidth = self.logoImage:getWidth()
    local logoX = screenWidth * 0.5
    local logoY = screenHeight * 0.25
    love.graphics.draw(self.logoImage, logoX, logoY, 0, logoScale, logoScale, logoImageWidth * 0.5, self.logoImage:getHeight() * 0.5)
end

function MainMenuScreen:inputDown()

end

function MainMenuScreen:inputUp()

end

function MainMenuScreen:inputSelect()

end

return MainMenuScreen