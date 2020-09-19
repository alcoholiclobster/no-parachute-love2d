local Concord = require("lib.concord")
local maf = require("lib.maf")

local BloodSpawn = Concord.system({
    pool = {"position", "bloodSpawnEvent"}
})

function BloodSpawn:update()
    for _, e in ipairs(self.pool) do
        local emitter = Concord.entity(self:getWorld())
            :give("position", maf.vec3(e.position.value.x, e.position.value.y, e.position.value.z))
            :give("particleEmitDelay", 0)
            :give("lifeTime", 0)
            :give("particleColor", 0.8, 0, 0, 0.5)
            :give("particleSize", 0.08, 0.1)
            :give("particleFriction", 4, 6)
            :give("particleGravity", maf.vec3(0, 0, -10))

        if e.bloodSpawnEvent.level == 1 then
            emitter
                :give("particleEmitCount", 10, 20)
                :give("particleSpeed", 0.1, 6, 0.1, 6, 0.1, 0.5)
                :give("particleLifeTime", 2, 3)
        elseif e.bloodSpawnEvent.level == 2 then
            emitter
                :give("particleEmitCount", 20, 30)
                :give("particleSpeed", 2, 8, 2, 8, 1, 2)
                :give("particleRandomRotation")
                :give("particleLifeTime", 2, 3)
        else
            emitter
                :give("particleEmitCount", 40, 60)
                :give("particleSpeed", -8, 8, -8, 8, 2, 5)
                :give("particleLifeTime", 2, 3)
                :give("particleSize", 0.08, 0.16)
                :give("particleRandomRotation")
        end

        e:destroy()
    end
end

return BloodSpawn