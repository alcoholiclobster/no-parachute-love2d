local class = require("lib.middleclass")
local mouseUtils = require("utils.mouse")
local widgets = require("ui.widgets")
local settings = require("config.settings")
local lz = require("utils.language").localize

local SettingsOverlay = class("SettingsOverlay")

function SettingsOverlay:initialize()
    self.items = {
        "settings item 1",
        "settings item 2",
        "settings item 3",
        "settings item 4",
        "settings item 5",
        "settings item 6",
        "settings item 7",
        "settings item 8",
        "settings item 9",
        "settings item 10",
        "settings item 11",
        "settings item 12",
    }
end

function SettingsOverlay:draw()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

    local overlayWidth = screenWidth * 0.5
    local overlayHeight = overlayWidth * 0.7
    local overlayX = (screenWidth - overlayWidth) / 2
    local overlayY = (screenHeight - overlayHeight) / 2

    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle("fill", overlayX, overlayY, overlayWidth, overlayHeight)

    love.graphics.setColor(1, 1, 1)
    local itemX, itemY = overlayX + overlayWidth * 0.05, overlayY + overlayHeight * 0.05
    local itemWidth, itemHeight = overlayWidth * 0.5 - (itemX - overlayX) * 2, overlayHeight * 0.04
    for _, item in ipairs(settings) do
        widgets.label(lz("lbl_settings_"..item.name), itemX, itemY, itemWidth, itemHeight, false, "left")
        itemY = itemY + itemHeight * 1.5
        love.graphics.rectangle("fill", itemX, itemY, itemWidth, itemHeight)
        itemY = itemY + itemHeight * 1.5
        if itemY + itemHeight * 3 > overlayY + overlayHeight then
            itemY = overlayY + overlayHeight * 0.05
            itemX = itemX + overlayWidth * 0.5
        end
    end

    if widgets.button(lz("btn_settings_close"), overlayX, overlayY + overlayHeight, overlayWidth, screenHeight * 0.05, false, "center") then
        self.isClosed = true
    end
end

return SettingsOverlay