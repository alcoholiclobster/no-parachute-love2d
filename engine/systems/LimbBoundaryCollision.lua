local Concord = require("lib.concord")
local mathUtils = require("utils.math")

local LimbBoundaryCollision = Concord.system({
    pool = {"position", "rotation", "limb", "alive", "obstacleCollisionCheckOffset"}
})

function LimbBoundaryCollision:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local offset = mathUtils.rotateVector2D(e.obstacleCollisionCheckOffset.value, e.rotation.value)
        local position = e.position.value + offset
        local maxPos = 5 - math.abs(e.size.value.x) * 0.1

        local isColliding = position.x < -maxPos or position.x > maxPos
            or position.y < -maxPos or position.y > maxPos

        if isColliding then
            e:give("limbDeatchRequest")
        end
    end
end

return LimbBoundaryCollision