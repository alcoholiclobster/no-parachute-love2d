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
    local planeSpawner = planeSpawnerEntity.planeSpawner
    local sidePlanesIndex = planeSpawner.sidePlanesIndex
    local levelConfig = self:getWorld().gameManager.levelConfig

    for _, e in ipairs(self.pool) do
        if e.sidePlane.typeIndex < sidePlanesIndex then
            e.sidePlane.typeIndex = e.sidePlane.typeIndex + 1

            local config = levelConfig.sidePlanes[e.sidePlane.typeIndex]
            local textureIndex = 1
            if config.pattern then
                if planeSpawner.sidePlanePatternIndex > #config.pattern then
                    planeSpawner.sidePlanePatternIndex = 1
                end

                textureIndex = config.textures[config.pattern[planeSpawner.sidePlanePatternIndex]]
            else
                textureIndex = config.textures[math.random(1, #config.textures)]
            end
            e:give("texture", assets.texture(textureIndex))
            if config.pattern then
                planeSpawner.sidePlanePatternIndex = planeSpawner.sidePlanePatternIndex + 1
            end
        end
    end
end

return SidePlaneTextures