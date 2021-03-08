local class = require("lib.middleclass")
local mouseUtils = require("utils.mouse")
local widgets = require("ui.widgets")
local settingsItems = require("config.settings")
local settings = require("core.settings")
local lz = require("utils.language").localize

local SettingsOverlay = class("SettingsOverlay")

function SettingsOverlay:initialize()
    self.spaceItems = {
        language = true,
        music_volume = true,
        particles_quality = true
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

    love.graphics.setColor(0, 0, 0, 0.9)
    love.graphics.rectangle("fill", overlayX, overlayY, overlayWidth, overlayHeight + overlayHeight * 0.06)

    local itemX, itemY = overlayX + overlayWidth * 0.05, overlayY + overlayHeight * 0.05
    local itemWidth, itemHeight = overlayWidth * 0.5 - (itemX - overlayX) * 2, overlayHeight * 0.04
    local buttonHeight = overlayHeight * 0.05
    for _, item in ipairs(settingsItems) do
        love.graphics.setColor(0.8, 0.8, 0.8)
        widgets.label(lz("lbl_settings_"..item.name), itemX, itemY, itemWidth, itemHeight, false, "left")
        itemY = itemY + itemHeight * 1.5

        local x, y = itemX, itemY
        local w, h = itemWidth / #item.values, buttonHeight
        for _, valueItem in ipairs(item.values) do
            if settings.get(item.name) == valueItem.value then
                love.graphics.setColor(130/255, 90/255, 150/255, 0.5)
                love.graphics.rectangle("fill", x+5, y, w-10, h)
            end
            love.graphics.setColor(0.5, 0.5, 0.5)
            love.graphics.rectangle("line", x+5, y, w-10, h)
            if widgets.button(lz(valueItem.name), x, y + h * 0.15, w, h * 0.6, false, "center") then
                settings.set(item.name, valueItem.value)
            end
            x = x + w
        end
        itemY = itemY + h * 1.5

        if self.spaceItems[item.name] then
            itemY = itemY + itemHeight * 2
        end

        if itemY + itemHeight * 1.5 + h * 1.5 > overlayY + overlayHeight then
            itemY = overlayY + overlayHeight * 0.05
            itemX = itemX + overlayWidth * 0.5
        end
    end

    if widgets.button(lz("btn_settings_close"), overlayX, overlayY + overlayHeight - overlayHeight * 0.05, overlayWidth, screenHeight * 0.05, false, "center") then
        self.isClosed = true
    end
end

return SettingsOverlay