local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local BloodParticleCollision = Concord.system({
    pool = {"particle", "velocity", "lastCollidedObstacle", "bloodParticle"}
})


function BloodParticleCollision:update(deltaTime)
    for _, e in ipairs(self.pool) do
        -- Create decal
        local obstacle = e.lastCollidedObstacle.value
        local tx, ty = e.lastCollidedObstacle.textureX, e.lastCollidedObstacle.textureY
        Concord.entity(self:getWorld())
            :give("deferredDecal", "blood_small"..math.random(1, 4), obstacle, tx, ty)

        e:destroy()
    end
end

return BloodParticleCollision