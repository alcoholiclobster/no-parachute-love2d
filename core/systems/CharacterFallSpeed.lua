local Concord = require("lib.concord")

local CharacterFallSpeed = Concord.system({
    pool = {"character", "velocity", "alive"},

})

function CharacterFallSpeed:update(deltaTime)
    local gameState = self:getWorld().gameState

    for _, e in ipairs(self.pool) do
        local targetVelocity = -gameState.fallSpeed
        e.velocity.value.z = e.velocity.value.z + (targetVelocity - e.velocity.value.z) * deltaTime * 5
    end
end

return CharacterFallSpeed