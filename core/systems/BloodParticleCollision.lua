local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local BloodParticleCollision = Concord.system({
    pool = {"particle", "velocity", "obstacleCollisionEvent", "bloodParticle"}
})


function BloodParticleCollision:update(deltaTime)
    for _, e in ipairs(self.pool) do
        -- Create decal
        local obstacle = e.obstacleCollisionEvent.value
        local tx, ty = e.obstacleCollisionEvent.textureX, e.obstacleCollisionEvent.textureY
        Concord.entity(self:getWorld())
            :give("deferredDecal", "blood_small"..math.random(1, 4), obstacle, tx, ty, math.random() * math.pi * 2)

        e:destroy()
    end
end

return BloodParticleCollision