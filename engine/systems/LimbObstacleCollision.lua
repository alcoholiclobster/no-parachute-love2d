local Concord = require("lib.concord")
local maf = require("lib.maf")

local LimbObstacleCollisionDetach = Concord.system({
    pool = {"limb", "alive", "obstacleCollisionEvent"}
})

function LimbObstacleCollisionDetach:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local obstacle = e.obstacleCollisionEvent.value

        -- Create blood
        Concord.entity(self:getWorld())
            :give("bloodSpawnEvent", 2)
            :give("position", maf.vec3(
                e.obstacleCollisionEvent.hitPosition.x,
                e.obstacleCollisionEvent.hitPosition.y,
                obstacle.position.value.z + 0.5
            ))

        -- Create decal
        local tx, ty = e.obstacleCollisionEvent.textureX, e.obstacleCollisionEvent.textureY
        Concord.entity(self:getWorld())
            :give("deferredDecal", "blood_limb", obstacle, tx, ty)

        -- Request limb detach
        e:give("limbDeatchRequest")
    end
end

return LimbObstacleCollisionDetach