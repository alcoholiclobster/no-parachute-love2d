local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local LimbPoses = Concord.system({
    pool = {"position", "rotation", "limbParent", "limbRotation", "limbRotationPoses"}
})

local velocityThreshold = 1

function LimbPoses:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local velocity = e.limbParent.value.moveDirection.value
        -- velocity = mathUtils.rotateVector2D(velocity, -e.limbParent.value.rotation.value)
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
        e.limbRotation.value = e.limbRotation.value + (targetRotation - e.limbRotation.value) * 5 * deltaTime + animAngle
    end
end

return LimbPoses