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

local function drawButton(text, x, y, width, height)
    local mx, my = love.mouse.getPosition( )
    local isMouseOver = mx > x and my > y and mx < x + width and my < y + height
    if isMouseOver then
        love.graphics.setColor(0.2, 0.5, 0.9, 1)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.setFont(assets.font("Roboto-Bold", 26))
    drawShadowText(text, x, y + height * 0.5 - 15, width, "left")

    if isMouseOver and mouseUtils.isMouseJustPressed() then
        return true
    end
end

return {
    drawButton = drawButton,
}