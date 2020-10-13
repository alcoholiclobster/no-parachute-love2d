local Concord = require("lib.concord")

local CharacterFallSpeed = Concord.system({
    pool = {"character", "velocity", "alive"}
})

function CharacterFallSpeed:update(deltaTime)
    local gameManager = self:getWorld().gameManager

    for _, e in ipairs(self.pool) do
        local targetVelocity = -gameManager.levelConfig.fallSpeed
        e.velocity.value.z = e.velocity.value.z + (targetVelocity - e.velocity.value.z) * deltaTime * 3
    end
end

return CharacterFallSpeed