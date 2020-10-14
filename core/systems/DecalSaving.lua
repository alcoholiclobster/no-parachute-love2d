local Concord = require("lib.concord")

local DecalSaving = Concord.system({
    pool = {"deferredDecal"},
    spawnedPlanesPool = {"planeSpawnEvent", "name"},
})

local maxDecalsPerPlane = 64
local savedDecals = {}

function DecalSaving:update()
    for _, e in ipairs(self.pool) do
        local entity = e.deferredDecal.entity
        if entity.name.value then
            if not savedDecals[entity.name.value] then
                savedDecals[entity.name.value] = {}
            end

            table.insert(savedDecals[entity.name.value], {
                textureX = e.deferredDecal.textureX,
                textureY = e.deferredDecal.textureY,
                rotation = e.deferredDecal.rotation,
                name = e.deferredDecal.name,
            })

            if #savedDecals[entity.name.value] > maxDecalsPerPlane then
                table.remove(savedDecals[entity.name.value], 1)
            end
        end
    end

    for _, e in ipairs(self.spawnedPlanesPool) do
        if savedDecals[e.name.value] then
            for _, d in ipairs(savedDecals[e.name.value]) do
                Concord.entity(self:getWorld())
                    :give("deferredDecal", d.name, e, d.textureX, d.textureY, d.rotation)
            end
        end
    end
end

return DecalSaving