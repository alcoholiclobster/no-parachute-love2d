local Concord = require("lib.concord")
local mathUtils = require("utils.math")

local LimbPoses = Concord.system({
    pool = {
        "position",
        "rotation",
        "attachToEntity",
        "attachRotation",
        "limb",
        "limbRotationPoses"
    }
})

local minVelocityMagnitude = 2.5

function LimbPoses:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local velocity = mathUtils.rotateVector2D(e.attachToEntity.value.velocity.value, -e.attachToEntity.value.rotation.value)
        local targetRotation = 0
        if math.abs(velocity.x) > math.abs(velocity.y) then
            if velocity.x > minVelocityMagnitude then
                targetRotation = e.limbRotationPoses.right
            elseif velocity.x < -minVelocityMagnitude then
                targetRotation = e.limbRotationPoses.left
            end
        else
            if velocity.y > minVelocityMagnitude then
                targetRotation = e.limbRotationPoses.down
            elseif velocity.y < -minVelocityMagnitude then
                targetRotation = e.limbRotationPoses.up
            end
        end

        local animAngle = math.sin(love.timer.getTime() * 2) * e.limbRotationPoses.down * 0.002
        if e.attachToEntity.value.alive then
            e.attachRotation.value = e.attachRotation.value + (targetRotation - e.attachRotation.value) * 5 * deltaTime + animAngle
        end
    end
end

return LimbPoses