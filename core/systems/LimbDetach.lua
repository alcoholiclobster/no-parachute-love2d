local Concord = require("lib.concord")
local maf = require("lib.maf")

local LimbDetach = Concord.system({
    pool = {"attachToEntity", "deathEvent", "alive", "limb"}
})

function LimbDetach:update(deltaTime)
    for _, e in ipairs(self.pool) do
        -- Spawn detached limb
        local velocityX = (math.random() - 0.5) * 4
        local velocityY = (math.random() - 0.5) * 4
        Concord.entity(self:getWorld())
            :give("name", "detached_limb")
            :give("detachedLimb")
            :give("drawable")
            :give("destroyOutOfBounds")
            :give("canCollideWithObstacles")
            :give("canCollideWithBoundaries")
            :give("position", e.position.value + maf.vec3(0, 0, 0.5))
            :give("velocity", maf.vec3(velocityX, velocityY, math.random() * 5))
            :give("gravity", maf.vec3(0, 0, -40))
            :give("size", maf.vec3(e.size.value.x, e.size.value.y, e.size.value.z))
            :give("rotation", e.rotation.value)
            :give("rotationSpeed", (math.random() - 0.5) * 2)
            :give("texture", e.texture.value)

        -- Shake camera
        if e.attachToEntity.value.controlledByPlayer then
            Concord.entity(self:getWorld()):give("cameraShakeSource", 2)
        end

        -- Change texture
        if e.limbMissingTexture then
            e:give("texture", e.limbMissingTexture.value)
        else
            e:remove("texture")
        end

        e:remove("alive")

        -- Decrease character acceleration
        if e.attachToEntity.value.acceleration then
            e.attachToEntity.value.acceleration.value = e.attachToEntity.value.acceleration.value * 0.75
        end
    end
end

return LimbDetach