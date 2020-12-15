local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local CharacterMovement = Concord.system({
    pool = {"character", "velocity", "moveDirection", "alive", "acceleration"},
})

function CharacterMovement:update(deltaTime)
    local gameManager = self:getWorld().gameManager

    for _, e in ipairs(self.pool) do
        local direction = mathUtils.rotateVector2D(e.moveDirection.value, e.rotation.value)
        if direction:length() > 1 then
            direction:normalize()
        end

        -- Increase horizontal speed when fall speed is above level fall speed
        -- local velocityIncrease = mathUtils.clamp01(e.velocity.value.z / -gameManager.levelConfig.fallSpeed - 1)
        local acceleration = e.acceleration.value-- * (1 + (velocityIncrease * 0.25))

        local velocityZ = e.velocity.value.z
        e.velocity.value = e.velocity.value + direction * acceleration * deltaTime
        e.velocity.value.z = velocityZ
    end
end

return CharacterMovement