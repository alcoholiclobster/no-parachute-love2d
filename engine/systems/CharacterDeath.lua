local Concord = require("lib.concord")
local maf = require("lib.maf")

local CharacterDeath = Concord.system({
    pool = {"character", "velocity", "alive", "lastCollidedObstacle"}
})

function CharacterDeath:update(deltaTime)
    for _, e in ipairs(self.pool) do
        if e.playerControlled then
            Concord.entity(self:getWorld()):give("cameraShakeEvent", 3)
        end
        local obstacle = e.lastCollidedObstacle.value
        e.position.value.z = obstacle.position.value.z + 0.5
        e.velocity.value = maf.vec3(0, 0, 0)
        e:remove("alive")
    end
end

return CharacterDeath