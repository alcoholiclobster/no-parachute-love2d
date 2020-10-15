local Concord = require("lib.concord")
local assets = require("core.assets")

local DecorativePlaneTextures = Concord.system({
    planeSpawnerPool = {"planeSpawner"},
    pool = {"decorativePlane", "decorativePlaneRespawnEvent", "position"},
})

function DecorativePlaneTextures:update()
    local planeSpawnerEntity = self.planeSpawnerPool[1]
    if not planeSpawnerEntity then
        return
    end
    local sidePlanesIndex = planeSpawnerEntity.planeSpawner.sidePlanesIndex
    local levelConfig = self:getWorld().gameManager.levelConfig

    for _, e in ipairs(self.pool) do
        if e.decorativePlane.typeIndex < sidePlanesIndex then
            e.decorativePlane.typeIndex = e.decorativePlane.typeIndex + 1

            local config = levelConfig.sidePlanes[e.decorativePlane.typeIndex]
            e:give("texture", assets.texture(config.textures[math.random(1, #config.textures)]))
        end
    end
end

return DecorativePlaneTextures