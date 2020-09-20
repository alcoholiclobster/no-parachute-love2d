local Concord = require("lib.concord")
local maf = require("lib.maf")

local LimbDetach = Concord.system({
    pool = {"attachToEntity", "lastCollidedObstacle", "alive", "limb"}
})

function LimbDetach:update(deltaTime)
    for _, e in ipairs(self.pool) do
        -- Spawn detached limb
        local obstacle = e.lastCollidedObstacle.value
        local detachedLimbPosition = maf.vec3(
            e.position.value.x,
            e.position.value.y,
            obstacle.position.value.z + 0.5
        )
        Concord.entity(self:getWorld())
            :give("name", "detached_limb")
            :give("drawable")
            :give("destroyOutOfBounds")
            :give("position", detachedLimbPosition)
            :give("size", maf.vec3(e.size.value.x, e.size.value.y, e.size.value.z))
            :give("rotation", e.rotation.value)
            :give("texture", e.texture.value)

        -- Shake camera
        if e.attachToEntity.value.playerControlled then
            Concord.entity(self:getWorld()):give("cameraShakeEvent", 2)
        end

        -- Change texture
        if e.limbMissingTexture then
            e:give("texture", e.limbMissingTexture.value)
        else
            e:remove("texture")
        end

        e:remove("alive")

        -- Create blood
        Concord.entity(self:getWorld())
            :give("bloodSpawnEvent", 2)
            :give("position", maf.vec3(
                e.lastCollidedObstacle.hitPosition.x,
                e.lastCollidedObstacle.hitPosition.y,
                obstacle.position.value.z + 0.5
            ))

        -- Create decal
        local tx, ty = e.lastCollidedObstacle.textureX, e.lastCollidedObstacle.textureY
        Concord.entity(self:getWorld())
            :give("deferredDecal", "blood_limb", obstacle, tx, ty)

        -- Decrease character acceleration
        if e.attachToEntity.value.acceleration then
            e.attachToEntity.value.acceleration.value = e.attachToEntity.value.acceleration.value * 0.5
        end
    end
end

return LimbDetach