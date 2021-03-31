local Concord = require("lib.concord")
local maf = require("lib.maf")
local settings = require("utils.settings")

local BloodSpawn = Concord.system({
    pool = {"position", "bloodSpawnEvent"}
})

-- Limit blood sources per frame
local maxEventsPerFrame = 4

function BloodSpawn:update()
    local processedCount = 0

    for _, e in ipairs(self.pool) do
        if settings.get("blood") then
            local emitter = Concord.entity(self:getWorld())
                :give("position", maf.vec3(e.position.value.x, e.position.value.y, e.position.value.z))
                :give("particleEmitDelay", 0)
                :give("lifeTime", 0)
                :give("particleColor", 0.8, 0, 0, 0.5)
                :give("particleSize", 0.08, 0.1)
                :give("particleFriction", 4, 4)
                :give("particleGravity", maf.vec3(0, 0, -30))
                :give("particleTag", "bloodParticle")
                :give("particleRandomRotation")

            if e.bloodSpawnEvent.level == 1 then
                emitter
                    :give("particleEmitCount", 5, 10)
                    :give("particleSpeed", -5, 5, -10, 10, -5, 1)
                    :give("particleLifeTime", 0.5, 1)
                    :give("particleGravity", maf.vec3(0, 0, -1))
            elseif e.bloodSpawnEvent.level == 2 then
                emitter
                    :give("particleEmitCount", 15, 20)
                    :give("particleSpeed", -5, 5, -10, 10, 0.1, 4)
                    :give("particleLifeTime", 2, 3)
                    :give("particleGravity", maf.vec3(0, 0, -40))
                    :give("particleCollisionEnabled")
            elseif e.bloodSpawnEvent.level == 3 then
                emitter
                    :give("particleEmitCount", 40, 60)
                    :give("particleSpeed", -8, 8, -8, 14, 3, 8)
                    :give("particleLifeTime", 6, 8)
                    :give("particleSize", 0.08, 0.16)
                    :give("particleCollisionEnabled")
            elseif e.bloodSpawnEvent.level == 4 then
                emitter
                    :give("particleEmitCount", 20, 40)
                    :give("particleSpeed", -5, 5, -10, 10, -36, 0)
                    :give("particleLifeTime", 0.5, 1)
                    :give("particleGravity", maf.vec3(0, 0, -1))
            end
        end

        e:destroy()

        processedCount = processedCount + 1
        if processedCount > maxEventsPerFrame then
            return
        end
    end
end

return BloodSpawn