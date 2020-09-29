local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")

local DetachedLimbCollision = Concord.system({
    pool = {"position", "velocity", "detachedLimb", "obstacleCollisionEvent"}
})

function DetachedLimbCollision:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local obstacle = e.obstacleCollisionEvent.value
        e:give("attachToEntity", obstacle)
        e:give("attachRotation", e.rotation.value - obstacle.rotation.value)
        local attachOffset = e.position.value - obstacle.position.value
        attachOffset = mathUtils.rotateVector2D(attachOffset, -obstacle.rotation.value)
        attachOffset.z = 0.5
        e:give("attachOffset", attachOffset)

        e.velocity.value = maf.vec3(0, 0, 0)
        e:remove("rotationSpeed")

        -- Create blood
        Concord.entity(self:getWorld())
            :give("bloodSpawnEvent", 1)
            :give("position", maf.vec3(
                e.position.value.x,
                e.position.value.y,
                obstacle.position.value.z + 0.25
            ))

        -- Create decal
        local tx, ty = e.obstacleCollisionEvent.textureX, e.obstacleCollisionEvent.textureY
        Concord.entity(self:getWorld())
            :give("deferredDecal", "blood_death", obstacle, tx, ty)
    end
end

return DetachedLimbCollision