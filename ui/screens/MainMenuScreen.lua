local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local GameManager = require("core.GameManager")
local musicManager = require("utils.musicManager")
local widgets = require("ui.widgets")
local lz = require("utils.language").localize
local assets = require("core.assets")
local SettingsOverlay = require("ui.SettingsOverlay")

local MainMenuScreen = class("MainMenuScreen", Screen)

function MainMenuScreen:initialize()
    musicManager:play("menu_theme")
    self.gameManager = GameManager:new(require("config.levels.deep_forest1"), self, true)

    self.buttons = {
        { label = "main_menu_btn_play_story", handler = "LevelSelectionScreen" },
        { label = "main_menu_btn_play_endless_mode", handler = "buttonHandlerPlayEndlessMode" },
        { label = "main_menu_btn_play_daily_challenge", handler = GameEnv.isSteamInitialized and "DailyChallengeScreen" or false },
        { label = "MODS", handler = GameEnv.isSteamInitialized and "WorkshopScreen" or false },
        {},
        { label = "btn_settings", handler = "buttonHandlerSettings" },
        { label = "main_menu_btn_credits", handler = "CreditsScreen"},
        {},
        { label = "btn_exit_game", handler = "buttonHandlerExit" },
    }

    self.highlightedButtonIndex = 1

    self.logoImage = assets.texture("logo")

    self.settingsOverlay = nil
    -- self:buttonHandlerSettings()
end

function MainMenuScreen:update(deltaTime)
    self.gameManager:update(deltaTime)
end

function MainMenuScreen:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    self.gameManager:draw()

    local btnX, btnY = screenWidth * 0.08, screenHeight * 0.5
    local btnWidth, btnHeight = screenWidth * (0.5 - 0.08 * 2), screenHeight * 0.04
    local btnSpace = screenHeight * 0.007
    for _, buttonData in ipairs(self.buttons) do
        if buttonData.label then
            local isPressed = widgets.button(lz(buttonData.label), btnX, btnY, btnWidth, btnHeight, not buttonData.handler or self.settingsOverlay)

            if isPressed and buttonData.handler then
                if self[buttonData.handler] then
                    self[buttonData.handler](self)
                else
                    self.screenManager:transition(buttonData.handler)
                end
            end
        end

        btnY = btnY + btnHeight + btnSpace
    end

    local logoScale = math.min(screenWidth * 0.0025, screenHeight * 0.0025)
    local logoX = screenWidth * 0.25
    local logoY = screenHeight * 0.25
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.logoImage, logoX, logoY, 0, logoScale, logoScale, self.logoImage:getWidth() * 0.5, self.logoImage:getHeight() * 0.5)

    if self.settingsOverlay then
        self.settingsOverlay:draw()
        if self.settingsOverlay.isClosed then
            self.settingsOverlay = nil
        end
    end
end

function MainMenuScreen:buttonHandlerPlayEndlessMode()
    GameEnv.endlessForceSeed = nil
    self.screenManager:transition("GameScreen", "endless")
end

function MainMenuScreen:buttonHandlerExit()
    love.event.quit()
end

function MainMenuScreen:buttonHandlerSettings()
    if not self.settingsOverlay then
        self.settingsOverlay = SettingsOverlay:new()
    end
end

function MainMenuScreen:handleWindowResize(...)
    self.gameManager:handleWindowResize(...)
end

return MainMenuScreen