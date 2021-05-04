local class = require("lib.middleclass")
local Screen = require("ui.Screen")
local widgets = require("ui.widgets")
local GameManager = require("core.GameManager")
local lz = require("utils.language").localize
local Steam = require("luasteam")

local WorkshopScreen = class("WorkshopScreen", Screen)

function WorkshopScreen:initialize()

end

function WorkshopScreen:update(deltaTime)

end

function WorkshopScreen:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    -- Back to menu screen button
    if widgets.button(lz("btn_back"), screenWidth * 0.08, screenHeight - screenHeight * 0.1, screenWidth * (0.5 - 0.08 * 2), screenHeight * 0.05) then
        self.screenManager:transition("MainMenuScreen")
    end
    -- Play button
    if widgets.button("Open mods folder", screenWidth * (0.7 - 0.04), screenHeight - screenHeight * 0.2, screenWidth * 0.3, screenHeight * 0.05, false, "right") then
        love.filesystem.createDirectory("mods")
        love.system.openURL("file://"..love.filesystem.getSaveDirectory().."/mods")
    end

    if widgets.button("Upload", screenWidth * (0.7 - 0.04), screenHeight - screenHeight * 0.1, screenWidth * 0.3, screenHeight * 0.05, false, "right") then
        print("Upload?")
    end
end

return WorkshopScreen