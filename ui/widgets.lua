local widgets = {}

local assets = require("core.assets")
local mouseUtils = require("utils.mouse")

local function drawShadowText(text, x, y, width, align)
    local w = 2
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 0, 0, a)
    love.graphics.printf(text, x+w, y+w, width, align)
    love.graphics.setColor(r, g, b, a)
    love.graphics.printf(text, x, y, width, align)
end

function widgets.button(text, x, y, width, height, isDisabled, align)
    local mx, my = love.mouse.getPosition()
    local isHighlighted = mx > x and my > y and mx < x + width and my < y + height and not isDisabled

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
        return true
    else
        return false
    end
end

return widgets