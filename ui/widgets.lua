local widgets = {}

local assets = require("core.assets")
local mouseUtils = require("utils.mouse")

local clickSound = assets.sound("ui_click.wav")
local hoverSound = assets.sound("ui_hover.wav")
local lastHighlightedButton = false

local starTexture = assets.texture("star")

local function drawShadowText(text, x, y, width, align)
    local w = 2
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 0, 0, a)
    love.graphics.printf(text, x+w, y+w, width, align)
    love.graphics.setColor(r, g, b, a)
    love.graphics.printf(text, x, y, width, align)
end

local function isPointWithinRect(x, y, rx, ry, rw, rh)
    return x > rx and y > ry and x < rx + rw and y < ry + rh
end

function widgets.label(text, x, y, width, height, isBold, align)
    love.graphics.setFont(assets.font(isBold and "Roboto-Bold" or "Roboto-Regular", math.floor(height)))
    drawShadowText(text, x, y + height * 0.1, width, align or "left")
end

function widgets.star(x, y, size, isCollected)
    if isCollected then
        love.graphics.setColor(0, 0, 0, 0.9)
        love.graphics.draw(starTexture, x + 4, y + 2, 0, size/starTexture:getWidth())
        love.graphics.setColor(1, 0.7, 0)
    else
        love.graphics.setColor(0, 0, 0, 0.5)
    end
    love.graphics.draw(starTexture, x, y, 0, size/starTexture:getWidth())
end

function widgets.button(text, x, y, width, height, isDisabled, align)
    local mx, my = love.mouse.getPosition()
    local isHighlighted = isPointWithinRect(mx, my, x, y, width, height) and not isDisabled
    -- if isHighlighted and lastHighlightedButton ~= text then
    --     hoverSound:stop()
    --     hoverSound:play()
    --     lastHighlightedButton = text
    -- elseif not isHighlighted and lastHighlightedButton == text then
    --     lastHighlightedButton = false
    -- end

    if isHighlighted then
        love.graphics.setColor(130/255, 90/255, 150/255, 1)
    else
        if isDisabled then
            love.graphics.setColor(0.5, 0.5, 0.5, 1)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
    love.graphics.setFont(assets.font("Roboto-Bold", math.floor(height * 0.75)))
    drawShadowText(text, x, y + height * 0.1, width, align or "left")

    if isHighlighted and mouseUtils.isMouseJustPressed() then
        mouseUtils.cancelClickEvent()
        clickSound:play()
        return true
    else
        return false
    end
end

return widgets