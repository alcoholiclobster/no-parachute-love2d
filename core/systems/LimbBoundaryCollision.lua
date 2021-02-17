local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")

local LimbBoundaryCollision = Concord.system({
    pool = {"position", "rotation", "limb", "alive", "obstacleCollisionCheckOffset"},
    tunnelCenterPool = {"position", "tunnelCenter"},
})

function LimbBoundaryCollision:update(deltaTime)
    local centerPos = maf.vec3(0, 0, 0)
    local tunnelHalfSize = 5
    if self.tunnelCenterPool[1] then
        centerPos = self.tunnelCenterPool[1].position.value
        tunnelHalfSize = self.tunnelCenterPool[1].size.value.x / 2
    end

    for _, e in ipairs(self.pool) do
        if not e.damageCooldown then
            local offset = mathUtils.rotateVector2D(e.obstacleCollisionCheckOffset.value, e.rotation.value)
            local position = e.position.value + offset
            local maxPos = tunnelHalfSize - math.abs(e.size.value.x) * 0.15

            local isCollidingLeft = position.x < -maxPos + centerPos.x
            local isCollidingRight = position.x > maxPos + centerPos.x
            local isCollidingUp = position.y < -maxPos + centerPos.y
            local isCollidingDown = position.y > maxPos + centerPos.y
            local isColliding = isCollidingLeft or isCollidingRight or isCollidingUp or isCollidingDown

            if isColliding and not e.damageEvent then
                e:give("damageEvent", 1)
                e:give("damageCooldown", math.random() * 0.2 + 0.3)

                local parentVelocity = e.attachToEntity.value.velocity
                local pushVelocity = math.max(4, #parentVelocity.value * 0.2)
                if isCollidingLeft then
                    parentVelocity.value.x = pushVelocity
                elseif isCollidingRight then
                    parentVelocity.value.x = -pushVelocity
                elseif isCollidingUp then
                    parentVelocity.value.y = pushVelocity
                elseif isCollidingDown then
                    parentVelocity.value.y = -pushVelocity
                end

                -- Create blood
                Concord.entity(self:getWorld())
                    :give("bloodSpawnEvent", 4, 1)
                    :give("position", maf.vec3(position))
            end
        end
    end
end

return LimbBoundaryCollision