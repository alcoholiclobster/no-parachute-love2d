local Concord = require("lib.concord")
local maf = require("lib.maf")
local mathUtils = require("utils.math")
local storage = require("utils.storage")

local CharacterDeath = Concord.system({
    pool = {"character", "velocity", "alive", "obstacleCollisionEvent"}
})

function CharacterDeath:update(deltaTime)
    for _, e in ipairs(self.pool) do
        if e.controlledByPlayer then
            Concord.entity(self:getWorld()):give("cameraShakeSource", 3)
        end

        e:remove("alive")

        local obstacle = e.obstacleCollisionEvent.value

        -- Create blood
        Concord.entity(self:getWorld())
            :give("bloodSpawnEvent", 3)
            :give("position", maf.vec3(
                e.position.value.x,
                e.position.value.y,
                obstacle.position.value.z + 0.2
            ))

        -- Create decal
        local tx, ty = e.obstacleCollisionEvent.textureX, e.obstacleCollisionEvent.textureY
        Concord.entity(self:getWorld())
            :give("deferredDecal", "blood_death", obstacle, tx, ty)

        -- UI
        if e.controlledByPlayer then
            local levelName = self:getWorld().gameManager.ui.levelName
            storage.setLevelData(levelName, "deaths", storage.getLevelData(levelName, "deaths", 0) + 1)
            storage.set("total_deaths", storage.get("total_deaths", 0) + 1)
            self:getWorld().gameManager:triggerUI("showDeathScreen")
        end
    end
end

return CharacterDeath