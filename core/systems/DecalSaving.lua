local Concord = require("lib.concord")

local DecalSaving = Concord.system({
    pool = {"deferredDecal"},
    spawnedPlanesPool = {"planeSpawnEvent", "name"},
})

local maxDecalsPerPlane = 64
local savedDecals = {}

function DecalSaving:update()
    local levelName = self:getWorld().gameManager.levelConfig.name
    if not savedDecals[levelName] then
        savedDecals[levelName] = {}
    end

    local levelDecals = savedDecals[levelName]
    for _, e in ipairs(self.pool) do
        local entity = e.deferredDecal.entity
        if entity.name.value then
            if not levelDecals[entity.name.value] then
                levelDecals[entity.name.value] = {}
            end

            table.insert(levelDecals[entity.name.value], {
                textureX = e.deferredDecal.textureX,
                textureY = e.deferredDecal.textureY,
                rotation = e.deferredDecal.rotation,
                name = e.deferredDecal.name,
            })

            if #levelDecals[entity.name.value] > maxDecalsPerPlane then
                table.remove(levelDecals[entity.name.value], 1)
            end
        end
    end

    for _, e in ipairs(self.spawnedPlanesPool) do
        if levelDecals[e.name.value] then
            for _, d in ipairs(levelDecals[e.name.value]) do
                Concord.entity(self:getWorld())
                    :give("deferredDecal", d.name, e, d.textureX, d.textureY, d.rotation)
            end
        end
    end
end

return DecalSaving