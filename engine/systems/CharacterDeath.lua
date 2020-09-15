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

        e:give("respawnTimeout", 3)

        -- Create blood
        Concord.entity(self:getWorld())
            :give("bloodSpawnEvent", 3)
            :give("position", maf.vec3(
                e.position.value.x,
                e.position.value.y,
                obstacle.position.value.z + 0.25
            ))
    end
end

return CharacterDeath