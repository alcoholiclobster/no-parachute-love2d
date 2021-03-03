local widgets = {}

local assets = require("core.assets")
local mouseUtils = require("utils.mouse")

local function drawShadowText(text, x, y, width, align)
    local w = 1
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 0, 0, a)
    love.graphics.printf(text, x-w, y-w, width, align)
    love.graphics.printf(text, x+w, y-w, width, align)
    love.graphics.printf(text, x-w, y+w, width, align)
    love.graphics.printf(text, x+w, y+w, width, align)
    love.graphics.printf(text, x+w, y, width, align)
    love.graphics.printf(text, x-w, y, width, align)
    love.graphics.printf(text, x, y+w, width, align)
    love.graphics.printf(text, x, y-w, width, align)
    love.graphics.setColor(r, g, b, a)
    love.graphics.printf(text, x, y, width, align)
end

function widgets.button(text, x, y, width, height, isHighlighted)
    if isHighlighted then
        love.graphics.setColor(0.2, 0.5, 0.9, 1)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.setFont(assets.font("Roboto-Bold", math.floor(height)))
    drawShadowText(text, x, y + height * 0.5 - 15, width, "left")
end

return widgets