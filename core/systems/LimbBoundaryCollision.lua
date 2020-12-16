local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")

local LimbBoundaryCollision = Concord.system({
    pool = {"position", "rotation", "limb", "alive", "obstacleCollisionCheckOffset"},
    tunnelCenterPool = {"position", "tunnelCenter"},
})

function LimbBoundaryCollision:update(deltaTime)
    local centerPos = maf.vec3(0, 0, 0)
    if self.tunnelCenterPool[1] then
        centerPos = self.tunnelCenterPool[1].position.value
    end

    for _, e in ipairs(self.pool) do
        local offset = mathUtils.rotateVector2D(e.obstacleCollisionCheckOffset.value, e.rotation.value)
        local position = e.position.value + offset
        local maxPos = 5 - math.abs(e.size.value.x) * 0.15

        local isCollidingLeft = position.x < -maxPos + centerPos.x
        local isCollidingRight = position.x > maxPos + centerPos.x
        local isCollidingUp = position.y < -maxPos + centerPos.y
        local isCollidingDown = position.y > maxPos + centerPos.y
        local isColliding = isCollidingLeft or isCollidingRight or isCollidingUp or isCollidingDown

        if isColliding and not e.damageEvent then
            e:give("damageEvent", 1)

            local parentVelocity = e.attachToEntity.value.velocity
            if isCollidingLeft then
                parentVelocity.value.x = 3
            elseif isCollidingRight then
                parentVelocity.value.x = -3
            elseif isCollidingUp then
                parentVelocity.value.y = 3
            elseif isCollidingDown then
                parentVelocity.value.y = -3
            end

            -- Create blood
            Concord.entity(self:getWorld())
                :give("bloodSpawnEvent", 1)
                :give("position", maf.vec3(position))
        end
    end
end

return LimbBoundaryCollision