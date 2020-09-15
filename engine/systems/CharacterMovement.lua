local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local CharacterMovement = Concord.system({
    pool = {"character", "velocity", "moveDirection", "alive"},
})

function CharacterMovement:update(deltaTime)
    for _, e in ipairs(self.pool) do
        local acceleration = 15
        local direction = mathUtils.rotateVector2D(e.moveDirection.value, e.rotation.value)
        local velocityZ = e.velocity.value.z
        e.velocity.value = e.velocity.value + direction * acceleration * deltaTime
        e.velocity.value.z = velocityZ
    end
end

return CharacterMovement