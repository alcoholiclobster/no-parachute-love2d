local widgets = {}

local assets = require("core.assets")
local mouseUtils = require("utils.mouse")

local clickSound = assets.sound("ui_click.wav")
local hoverSound = assets.sound("ui_hover.wav")
local lastHighlightedButton = false

local starCollectedTexture = assets.texture("star")
local starNotCollectedTexture = assets.texture("star_not_collected")
local starIconTexture = assets.texture("star_icon")
local starNotCollectedIconTexture = assets.texture("star_icon_not_collected")
local starMaskTexture = assets.texture("star_mask")

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

function widgets.star(x, y, size, isCollected, isIcon)
    local texture = starNotCollectedTexture
    if isCollected then
        texture = starCollectedTexture
        if isIcon then
            texture = starIconTexture
        end
    elseif isIcon then
        texture = starNotCollectedIconTexture
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(texture, x, y, 0, size/texture:getWidth())

    local mx, my = love.mouse.getPosition()
    local isHighlighted = isPointWithinRect(mx, my, x, y, size, size)
    if isHighlighted and not isIcon then
        love.graphics.setColor(1, 1, 1, 0.4)
        love.graphics.draw(starMaskTexture, x, y, 0, size/texture:getWidth())
    end

    return isHighlighted
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