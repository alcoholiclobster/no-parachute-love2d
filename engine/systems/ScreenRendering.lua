local Concord = require("lib.concord")

local ScreenRendering = Concord.system({
    pool = {"position2d", "size2d"}
})

function ScreenRendering:draw()
    love.graphics.origin()
    for _, e in ipairs(self.pool) do
        if e.color then
            love.graphics.setColor(e.color.r, e.color.g, e.color.b, e.color.a)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
        if e.texture then
            love.graphics.draw(e.texture.value, e.position2d.x, e.position2d.y)
        else
            love.graphics.rectangle("fill", e.position2d.x, e.position2d.y, e.size2d.x, e.size2d.y)
        end
    end
end

return ScreenRendering