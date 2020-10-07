local Concord = require("lib.concord")
local mathUtils = require("utils.math")
local maf = require("lib.maf")

local ObstacleCollisionProcessing = Concord.system({
    pool = {"position", "velocity", "canCollideWithBoundaries", "obstacleCollisionEvent"}
})

function ObstacleCollisionProcessing:update(deltaTime)
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
    end
end

return ObstacleCollisionProcessing