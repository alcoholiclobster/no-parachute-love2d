local Concord = require("lib.concord")
local mathUtils = require("utils.math")

local CharacterMovement = Concord.system({
    pool = {"character", "velocity", "moveDirection", "alive", "acceleration"},
})

function CharacterMovement:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local direction = mathUtils.rotateVector2D(e.moveDirection.value, e.rotation.value)
        if direction:length() > 1 then
            direction:normalize()
        end

        local acceleration = e.acceleration.value

        local velocityZ = e.velocity.value.z
        e.velocity.value = e.velocity.value + direction * acceleration * deltaTime
        e.velocity.value.z = velocityZ
    end
end

return CharacterMovement