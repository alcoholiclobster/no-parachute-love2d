local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")

local CharacterDeath = Concord.system({
    pool = {"character", "velocity", "alive", "lastCollidedObstacle"}
})

function CharacterDeath:update(deltaTime)
    for _, e in ipairs(self.pool) do
        if e.playerControlled then
            Concord.entity(self:getWorld()):give("cameraShakeEvent", 3)
        end

        local obstacle = e.lastCollidedObstacle.value
        e:give("attachToEntity", obstacle)
        e:give("attachRotation", e.rotation.value - obstacle.rotation.value)
        local attachOffset = e.position.value - obstacle.position.value
        attachOffset = mathUtils.rotateVector2D(attachOffset, -obstacle.rotation.value)
        attachOffset.z = 0.5
        e:give("attachOffset", attachOffset)

        e.velocity.value = maf.vec3(0, 0, 0)
        e:remove("alive")
        e:remove("rotationSpeed")
        e:give("respawnTimeout", 3)

        -- Create blood
        Concord.entity(self:getWorld())
            :give("bloodSpawnEvent", 3)
            :give("position", maf.vec3(
                e.position.value.x,
                e.position.value.y,
                obstacle.position.value.z + 0.25
            ))

        -- Create decal
        local tx, ty = e.lastCollidedObstacle.textureX, e.lastCollidedObstacle.textureY
        Concord.entity(self:getWorld())
            :give("deferredDecal", "blood_death", obstacle, tx, ty)
    end
end

return CharacterDeath