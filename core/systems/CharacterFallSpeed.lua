local Concord = require("lib.concord")
local settings = require("utils.settings")

local CharacterFallSpeed = Concord.system({
    pool = {"character", "velocity", "alive"},

})

function CharacterFallSpeed:update(deltaTime)
    local gameState = self:getWorld().gameState
    local targetVelocity = -gameState.fallSpeed
    if settings.get("difficulty") == "easy" then
        targetVelocity = targetVelocity * 0.8
    elseif settings.get("difficulty") == "peaceful" then
        targetVelocity = targetVelocity * 0.5
    end

    for _, e in ipairs(self.pool) do
        e.velocity.value.z = e.velocity.value.z + (targetVelocity - e.velocity.value.z) * deltaTime * 5
    end
end

return CharacterFallSpeed