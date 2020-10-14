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

local minVelocityMagnitude = 0.1

function LimbPoses:update(deltaTime)
    local gameManager = self:getWorld().gameManager

    for _, e in ipairs(self.pool) do
        local velocity = e.attachToEntity.value.velocity.value
        local velocityIncrease = mathUtils.clamp01(velocity.z / -gameManager.levelConfig.fallSpeed - 1)

        local moveDirection = e.attachToEntity.value.moveDirection.value--mathUtils.rotateVector2D(e.attachToEntity.value.velocity.value, -e.attachToEntity.value.rotation.value)
        local targetRotation = 0
        if math.abs(moveDirection.x) > math.abs(moveDirection.y) then
            if moveDirection.x > minVelocityMagnitude then
                targetRotation = e.limbRotationPoses.right
            elseif moveDirection.x < -minVelocityMagnitude then
                targetRotation = e.limbRotationPoses.left
            end
        else
            if moveDirection.y > minVelocityMagnitude then
                targetRotation = e.limbRotationPoses.down
            elseif moveDirection.y < -minVelocityMagnitude then
                targetRotation = e.limbRotationPoses.up
            end
        end

        local animAngle = math.sin(love.timer.getTime() * 2) * e.limbRotationPoses.down * 0.002 + e.limbRotationPoses.up * velocityIncrease * 0.025 * math.sin(love.timer.getTime() * 10)
        if e.attachToEntity.value.alive then
            e.attachRotation.value = e.attachRotation.value + (targetRotation - e.attachRotation.value) * 7 * deltaTime + animAngle
        end
    end
end

return LimbPoses