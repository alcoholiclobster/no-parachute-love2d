local Concord = require("lib.concord")

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

local velocityThreshold = 1

function LimbPoses:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local velocity = e.attachToEntity.value.moveDirection.value
        local targetRotation = 0
        if math.abs(velocity.x) > math.abs(velocity.y) then
            if velocity.x > velocityThreshold then
                targetRotation = e.limbRotationPoses.right
            elseif velocity.x < -velocityThreshold then
                targetRotation = e.limbRotationPoses.left
            end
        else
            if velocity.y > velocityThreshold then
                targetRotation = e.limbRotationPoses.down
            elseif velocity.y < -velocityThreshold then
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