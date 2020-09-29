local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")

local DetachedLimbCollision = Concord.system({
    pool = {"position", "velocity", "detachedLimb", "obstacleCollisionEvent"}
})

function DetachedLimbCollision:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local obstacle = e.obstacleCollisionEvent.value

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