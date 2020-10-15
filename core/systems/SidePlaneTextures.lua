local Concord = require("lib.concord")
local assets = require("core.assets")

local SidePlaneTextures = Concord.system({
    planeSpawnerPool = {"planeSpawner"},
    pool = {"sidePlane", "sidePlaneRespawnEvent", "position"},
})

function SidePlaneTextures:update()
    local planeSpawnerEntity = self.planeSpawnerPool[1]
    if not planeSpawnerEntity then
        return
    end
    local sidePlanesIndex = planeSpawnerEntity.planeSpawner.sidePlanesIndex
    local levelConfig = self:getWorld().gameManager.levelConfig

    for _, e in ipairs(self.pool) do
        if e.sidePlane.typeIndex < sidePlanesIndex then
            e.sidePlane.typeIndex = e.sidePlane.typeIndex + 1

            local config = levelConfig.sidePlanes[e.sidePlane.typeIndex]
            e:give("texture", assets.texture(config.textures[math.random(1, #config.textures)]))
        end
    end
end

return SidePlaneTextures