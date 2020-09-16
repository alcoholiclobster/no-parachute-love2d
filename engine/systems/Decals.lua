local Concord = require("lib.concord")
local assets = require("engine.assets")

local Decals = Concord.system({
    pool = {"deferredDecal"}
})

function Decals:update()
    for _, e in ipairs(self.pool) do
        local entity = e.deferredDecal.entity
        if entity.texture.value:type() == "Canvas" then
            local texture = assets.texture("effects/"..e.deferredDecal.name)
            local x = e.deferredDecal.textureX - texture:getWidth()*0.5
            local y = e.deferredDecal.textureY - texture:getHeight()*0.5
            love.graphics.setCanvas(entity.texture.value)
            love.graphics.setBlendMode("multiply", "premultiplied")
            love.graphics.draw(texture, x, y)
            love.graphics.setCanvas()
            love.graphics.setBlendMode("alpha")
        end
        e:destroy()
    end
end

return Decals