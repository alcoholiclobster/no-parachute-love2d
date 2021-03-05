local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local GameManager = require("core.GameManager")
local musicManager = require("utils.musicManager")
local widgets = require("ui.widgets")
local lz = require("utils.language").localize
local assets = require "core.assets"

local MainMenuScreen = class("MainMenuScreen", Screen)

function MainMenuScreen:initialize()
    musicManager:play("menu_theme")
    self.gameManager = GameManager:new(require("config.levels.deep_forest1"), self, true)

    self.buttons = {
        { label = "main_menu_btn_play_story", handler = "buttonHandlerPlayStory" },
        { label = "main_menu_btn_play_daily_challenge" },
        { label = "main_menu_btn_play_endless_mode" },
        { label = "btn_settings" },
        {},
        { label = "btn_exit_game", handler = "buttonHandlerExit" },
    }

    self.highlightedButtonIndex = 1

    self.logoImage = assets.texture("logo")
end

function MainMenuScreen:update(deltaTime)
    self.gameManager:update(deltaTime)
end

function MainMenuScreen:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    self.gameManager:draw()

    local btnX, btnY = screenWidth * 0.08, screenHeight * 0.5
    local btnWidth, btnHeight = screenWidth * (0.5 - 0.08 * 2), screenHeight * 0.05
    local btnSpace = screenHeight * 0.01
    for _, buttonData in ipairs(self.buttons) do
        if buttonData.label then
            local isPressed = widgets.button(lz(buttonData.label), btnX, btnY, btnWidth, btnHeight, not buttonData.handler)

            if isPressed and buttonData.handler and self[buttonData.handler] then
                self[buttonData.handler](self)
            end
        end

        btnY = btnY + btnHeight + btnSpace
    end

    local logoScale = math.min(screenWidth * 0.0025, screenHeight * 0.0025)
    local logoX = screenWidth * 0.25
    local logoY = screenHeight * 0.25
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.logoImage, logoX, logoY, 0, logoScale, logoScale, self.logoImage:getWidth() * 0.5, self.logoImage:getHeight() * 0.5)
end

function MainMenuScreen:buttonHandlerPlayStory()
    self.screenManager:transition("LevelSelectionScreen")
end

function MainMenuScreen:buttonHandlerExit()
    love.event.quit()
end

return MainMenuScreen