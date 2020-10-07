local assets = require("core.assets")
local mouseUtils = require("utils.mouse")

local function drawButton(text, x, y, width, height)
    local mx, my = love.mouse.getPosition( )
    local isMouseOver = mx > x and my > y and mx < x + width and my < y + height
    love.graphics.setColor(1, 1, 1, isMouseOver and 1 or 0.5)
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(assets.font("Roboto-Bold", 14))
    love.graphics.printf(text, x, y + height * 0.5 - 7, width, "center")

    if isMouseOver and love.mouse.isDown(1) then
        return true
    end
end

return {
    drawButton = drawButton,
}