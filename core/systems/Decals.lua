local Concord = require("lib.concord")
local assets = require("core.assets")
local settings = require "core.settings"

local Decals = Concord.system({
    pool = {"deferredDecal"}
})

function Decals:update()
    for _, e in ipairs(self.pool) do
        local entity = e.deferredDecal.entity
        if settings.get("decals") and entity.texture.value:type() == "Canvas" then
            local texture = assets.texture("effects/"..e.deferredDecal.name)
            local textureWidth = texture:getWidth()
            local textureHeight = texture:getHeight()
            local x = e.deferredDecal.textureX
            local y = e.deferredDecal.textureY
            love.graphics.setCanvas(entity.texture.value)
            love.graphics.setBlendMode("multiply", "premultiplied")
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(texture, x, y, e.deferredDecal.rotation, 1, 1, textureWidth * 0.5, textureHeight * 0.5)
            love.graphics.setCanvas()
            love.graphics.setBlendMode("alpha")
        end
        e:destroy()
    end
end

return Decals